#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	ZScaler-Protection-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Determine if ZScaler Protection is in place by checking if the ZscalerTunnel Process exists and is running
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
PROCESS="ZscalerTunnel"
ProcessRunning=$(sudo pgrep -x $PROCESS)
#
if [ "$ProcessRunning" != "" ]
	then
		/bin/echo '<result>Protected</result>'
	else 
		/bin/echo '<result>NOT Protected</result>'
fi
