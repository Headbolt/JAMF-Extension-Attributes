#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	LegacyEFI-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Grab the status of the "Legacy EFI Password"
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.1 - 12/05/2025
#
#	01/03/2023 - V1.0 - Created by Headbolt
#
#	12/05/2025 - V1.1 - Updated by Headbolt
#							Legislating for Unsupported devices returning huge amounts of rubbish
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
firmwarepasswd=$(/usr/sbin/firmwarepasswd -check  2>&1)
#
if [[ $(/bin/echo $firmwarepasswd | awk '{print $NF}') == "No" ]]
	then
        /bin/echo "<result>$(/bin/echo $firmwarepasswd | awk '{print $NF}')</result>"
	else
		if [[ $(/bin/echo $firmwarepasswd | awk '{print $NF}') == "Yes" ]]
			then
				/bin/echo "<result>$(/bin/echo $firmwarepasswd | awk '{print $NF}')</result>"
			else
				if [[ $(/bin/echo $firmwarepasswd | grep "The firmware on this machine is not supported") != "" ]]
					then
						/bin/echo "<result>"The firmware on this machine is not supported"</result>"
					else
						/bin/echo "<result>No Result</result>"
				fi
		fi
fi
