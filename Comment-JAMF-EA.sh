#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	Comment-JAMF-EA.sh
#	https://github.com/Headbolt/Comment-JAMF-EA
#
#   This Script is designed for use in JAMF
#
#   - This script will add a specified value to a specified EA
#
#	The API User Account for this script requires the following permissions within JAMF.
#	Computer Extension Attributes - Read and Update
#	Computers - Read and Update
#	Users - Read and Update - Why this is needed is not 100% Clear, but the script fails without it.
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 12/08/2026
#
#	- 12/08/2026 - V1.0 - Created by Headbolt
#
###############################################################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################################################
#
# Grab the first part of the API URL from JAMF variable #4 eg. https://COMPANY-NAME.jamfcloud.com
apiURL=$4
# Grab the username for API Login from JAMF variable #5 eg. username
apiUser=$5
# Grab the password for API Login from JAMF variable #6 eg. password
apiPass=$6
# Grab the extension atttribute name from JAMF variable #7 eg. username's password
ExtensionAttributeName=${7}
# Grab the Value to Add to the EA from JAMF variable #8 eg. password
Comment=$8
#
ScriptName="MacOS | Update EA with Value" # Set the name of the script for later logging
extAttName=$(echo "\"${ExtensionAttributeName}"\") # Place " quotation marks around extension attribute name in the variable
udid=$(/usr/sbin/system_profiler SPHardwareDataType | /usr/bin/awk '/Hardware UUID:/ { print $3 }') # Grab UUID of machine
jamf_binary="/usr/local/bin/jamf" # Set path the JAMF Binary - Depends on version being run
#
ExitCode=0 # Set Initial ExitCode
#
xmlString="<?xml version=\"1.0\" encoding=\"UTF-8\"?><computer><extension_attributes><extension_attribute><name>$ExtensionAttributeName</name><value>$Comment</value></extension_attribute></extension_attributes></computer>"
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
# Verify all parameters are present
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
if [ "$extAttName" == "" ]
	then
		/bin/echo "Error:  The parameter 'Extension Attribute Name' is blank.  Please specify an Extension Attribute Name."
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
# Update the LAPS Extention Attribute
#
UpdateAPI (){
#
/bin/echo "Updating the EA for the Comupter Record."
execute=$(/usr/bin/curl -s -X PUT -H 'Authorization: Bearer '$token'' -H "Content-Type: text/xml" -d "${xmlString}" "${apiURL}/JSSResource/computers/udid/$udid" 2>&1 /dev/null)
Update=$(curl -s -f "Accept: application/xml" $apiURL/JSSResource/computers/udid/$udid/subset/extension_attributes -H 'Authorization: Bearer '$token'' | xpath -e "//extension_attribute[name=$extAttName]" 2>&1 | awk -F'<value>|</value>' '{print $2}')
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
/bin/echo # Outputting a Blank Line for Reporting Purposes
SectionEnd
#
ParameterCheck
SectionEnd
#
AuthToken
SectionEnd
#
UpdateAPI
SectionEnd
#
ScriptEnd
