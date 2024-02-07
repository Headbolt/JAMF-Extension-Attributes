#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	SSV-EXT.sh
#	https://github.com/Headbolt/SSV-EXT
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Grab the status of the "Sealed System Volume"
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
SSVenabled=$(/usr/bin/sudo /usr/bin/csrutil authenticated-root status | grep "enabled")
#
if [[ "$SSVenabled" != "" ]]
	then
    	result="Enabled"
	else
		result="Disabled"
fi
/bin/echo "<result>$result</result>"
