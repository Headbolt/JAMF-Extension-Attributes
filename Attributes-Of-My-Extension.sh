#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	Attributes-Of-My-Extension.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF
#
#   - This script will ...
#			Check and Update the requested Extension Attribute
#
#			The Following Variables should be defined
#			Variable 4 - Named "Extension Attribute Name - eg. Wallpaper Style"
#			Variable 5 - Named "Extension Attribute Value - eg. Grayscale"
#			Variable 6 - Named "API URL - eg. https://mycompany.jamfcloud.com"
#			Variable 7 - Named "API User - eg. API-User"
#			Variable 8 - Named "API User Password - eg. YetAnotherPasswordyThing"
#
#			The API User set in Variable 7 will need the following permisions ONLY
#			Jamf Pro Server Objects > Read perms for Computers
#			Computer Extension Attributes - Read and Update
#			Computers - Read and Update
#			Users - Read and Update - Why this is needed is not 100% Clear, but the script fails without it.
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 22/09/2025
#
#	- 22/09/2025 - V1.0 - Created by Headbolt
#
###############################################################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################################################
#
ExtensionAttributeName=${4} # Grab the extension atttribute name from JAMF variable #4 eg. ExtAtt
ExtensionAttributeValue=${5} # Grab the extension atttribute value from JAMF variable #5 eg. ExtAttVal
apiURL=$6 # Grab the first part of the API URL from JAMF variable #6 eg. https://COMPANY-NAME.jamfcloud.com
apiUser=$7 # Grab the username for API Login from JAMF variable #7 eg. username
apiPass=$8 # Grab the password for API Login from JAMF variable #8 eg. password
#
ScriptVer="v1.0" # Set the Script Version for logging purposes
ScriptName="MacOS | Update Extension Attribute via API" # Set the name of the script for later logging
#
extAttName=$(echo "\"${ExtensionAttributeName}"\") # Place " quotation marks around extension attribute name in the variable
udid=$(/usr/sbin/system_profiler SPHardwareDataType | /usr/bin/awk '/Hardware UUID:/ { print $3 }') # Grab UUID of machine
ExitCode=0 # Set Initial ExitCode
xmlString="<?xml version=\"1.0\" encoding=\"UTF-8\"?><computer><extension_attributes><extension_attribute><name>$ExtensionAttributeName</name><value>$ExtensionAttributeValue</value></extension_attribute></extension_attributes></computer>"
#
###############################################################################################################################################
#
###############################################################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
#
# Defining Functions
#
###############################################################################################################################################
#
# Verifiy all Required Parameters are set.
#
ParameterCheck(){
#
/bin/echo 'Checking parameters.'
#
if [ "$extAttName" == "" ]
	then
		/bin/echo "Error:  The parameter 'Extension Attribute Name' is blank.  Please specify an Extension Attribute Name."
		ExitCode=1
		ScriptEnd
fi
#
if [ "$ExtensionAttributeValue" == "" ]
	then
		/bin/echo "Error:  The parameter 'Extension Attribute Name' is blank.  Please specify an Extension Attribute Name."
		ExitCode=1
		ScriptEnd
fi
#
if [ "$apiURL" == "" ]
	then
	    /bin/echo "Error:  The parameter 'API URL' is blank.  Please specify a URL."
		ExitCode=1
		ScriptEnd
fi
#
if [ "$apiUser" == "" ]
	then
	    /bin/echo "Error:  The parameter 'API Username' is blank.  Please specify a user."
		ExitCode=1
		ScriptEnd
fi
#
if [ "$apiPass" == "" ]
	then
	    /bin/echo "Error:  The parameter 'API Password' is blank.  Please specify a password."
		ExitCode=1
		ScriptEnd
fi
#
/bin/echo 'Parameters Verified.'
#
}
#
###############################################################################################################################################
#
# Auth Token Function
#
AuthToken (){
#
/bin/echo 'Getting Athentication Token from JAMF'
rawtoken=$(curl -s -u "${apiUser}:${apiPass}" -X POST "${apiURL}/api/v1/auth/token" | grep token) # This Authenticates against the JAMF API with the Provided details and obtains an Authentication Token
rawtoken=${rawtoken%?};
token=$(echo $rawtoken | awk '{print$3}' | cut -d \" -f2)
#
}
#
###############################################################################################################################################
#
# Check the current value of the Extension Attribute
#
CheckValue (){
#
/bin/echo 'Grabbing Current Extension Attribute Value From JAMF API'
CurrentExtensionAttributeValue=$(curl -s -X GET "${apiURL}/JSSResource/computers/udid/$udid/subset/extension_attributes" -H 'Authorization: Bearer '$token'' | xpath -e "//extension_attribute[name=$extAttName]" 2>&1 | awk -F'<value>|</value>' '{print $2}')
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
if [ "$CurrentExtensionAttributeValue" == "" ]
	then
	    /bin/echo 'No Value is stored in JAMF.'
	else
	    /bin/echo 'A Value of "'$CurrentExtensionAttributeValue'" was found in JAMF.'
fi
#
}
#
###############################################################################################################################################
#
# Update the value via the API
#
UpdateAPI (){
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo "Recording new value for $ExtensionAttributeName into JAMF."
/bin/echo # Outputting a Blank Line for Reporting Purposes
/usr/bin/curl -s -X PUT -H 'Authorization: Bearer '$token'' -H "Content-Type: text/xml" -d "${xmlString}" "${apiURL}/JSSResource/computers/udid/$udid" 2>&1 /dev/null
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
}
#
###############################################################################################################################################
#
# Script Start Function
#
ScriptStart(){
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
SectionEnd
/bin/echo Starting Script '"'$ScriptName'"'
/bin/echo Script Version '"'$ScriptVer'"'
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
}
#
###############################################################################################################################################
#
# Section End Function
#
SectionEnd(){
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
}
#
###############################################################################################################################################
#
# Script End Function
#
ScriptEnd(){
#
/bin/echo Ending Script '"'$ScriptName'"'
/bin/echo # Outputting a Blank Line for Reporting Purposes
/bin/echo  ----------------------------------------------- # Outputting a Dotted Line for Reporting Purposes
/bin/echo # Outputting a Blank Line for Reporting Purposes
exit $ExitCode
#
}
#
###############################################################################################################################################
#
# End Of Function Definition
#
###############################################################################################################################################
#
# Beginning Processing
#
###############################################################################################################################################
#
ScriptStart
#
ParameterCheck
SectionEnd
#
AuthToken
SectionEnd
#
CheckValue
SectionEnd
#
if [ "$CurrentExtensionAttributeValue" == "$ExtensionAttributeValue" ]
	then
	    /bin/echo 'Value is already correct.'
		SectionEnd
	else
	    /bin/echo 'Value is incorrect, updating it.'
		UpdateAPI
		SectionEnd
        CheckValue
		SectionEnd
fi
#
ScriptEnd
