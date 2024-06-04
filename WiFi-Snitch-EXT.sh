#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	WiFi-Snitch-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Export the current WiFi SSID and BSSID if connected
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.1 - 03/06/2024
#
#	18/04/2014 - V1.0 - Created by Headbolt
#
#	03/06/2024 - V1.1 - Updated by Headbolt
#				As of macOS 14.5.0, "wdutil info" returns SSID and BSSID as "<redacted>"
#				New version works around it by using "networksetup -getairportnetwork en0"
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
ConnectedSSID=$(networksetup -getairportnetwork en0 | awk -F': ' '{print $2}')

if [ "$ConnectedSSID" == "" ]
	then
		RESULT="No WiFi Data Gathered"
	else
		RESULT=$(/bin/echo "SSID = $ConnectedSSID")
fi

/bin/echo "<result>$RESULT</result>"
