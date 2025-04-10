#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	CortexXDR-Protection-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Determine if Cotrex XDR Protection is in place by checking if CYTOOL exists and is running
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 10/04/2025
#
#	10/04/2025 - V1.0 - Created by Headbolt
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
CYTOOL="/Library/Application Support/PaloAltoNetworks/Traps/bin/cytool"
#
if [[ -x "$CYTOOL" ]]
	then
		CYTOOLstatus=$("$CYTOOL" opswat protected 2>/dev/null | tr -d '[:space:]')
		if [[ "$CYTOOLstatus" == "true" ]]
			then
				/bin/echo '<result>Protected</result>'
			else
				/bin/echo '<result>NOT Protected</result>'
		fi
	else
		/bin/echo '<result>NOT Protected</result>'
fi
