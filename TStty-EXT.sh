#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	TStty-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Ensure a Separate Timestamp Is Enabled for Each User/tty Combo
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
Check=$(/usr/bin/sudo /usr/bin/sudo -V | /usr/bin/grep -c "Type of authentication timestamp record: tty")
#
if [[ "$Check" == "1" ]]
	then
    	result="Enabled"
	else
		result="Disabled"
fi
/bin/echo "<result>$result</result>"
