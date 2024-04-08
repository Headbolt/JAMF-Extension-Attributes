#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	Last-LoginSudoAuth-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Check the Logs to see if the specified user account has been used
#		Either By Login, Sudo'ing as it, or Athenticating as it to elevate priveledges
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 08/04/2024
#
#	08/04/2024 - V1.0 - Created by Headbolt
#
###############################################################################################################################################
#
#   DEFINE VARIABLES
#
###############################################################################################################################################
#
Range="2h" # Set how far back in the logs to look in .. m ( Minutes ) h ( Hours ) d ( Days )
User="Nigel" # Set Account to Look for
#
###############################################################################################################################################
# 
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
#
# Beginning Processing
#
###############################################################################################################################################
#
/bin/echo # Outputting a Blank Line for Reporting Purposes
#
LogDumpAuth=$(log show --style syslog --last $Range | grep "Validating credential $User") # Look for "Validating credential" for the User

if [[ $LogDumpAuth == "" ]] # Check if log result indicates User has Authenticated
	then
		LogDumpSudo=$(log show --style syslog --last $Range | grep sudo | grep $User) # Look for "Sudo" for the User
		if [[ $LogDumpSudo == "" ]]  # Check if log result indicates User has been SUDO'd
			then
				LogDumpLogin=$(log show --style syslog --last $Range | grep 'User "'$User'" is logged in') # Look for "Log In" for the User
                if [[ $LogDumpLogin == "" ]]  # Check if log result indicates User has Logged In
					then
						/bin/echo "NO"
					else
						/bin/echo "<result>LOGIN</result>"
				fi
			else
				/bin/echo "<result>SUDO</result>"
		fi
	else
		/bin/echo "<result>AUTH</result>"
fi
