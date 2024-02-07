#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	RootUserEnabled-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Grab the status of the "root" user account
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 01/03/2023
#
#	01/03/2023 - V1.0 - Created by Headbolt
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
RootEnabled=$(/usr/bin/sudo /usr/bin/dscl . -read /Users/root AuthenticationAuthority | /usr/bin/grep "No such key: AuthenticationAuthority")
#
if [[ "$RootEnabled" != "" ]]
	then
    	result="Enabled"
	else
		result="Disabled"
fi
/bin/echo "<result>$result</result>"
