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
#	Version: 1.0 - 18/04/2024
#
#	18/04/2014 - V1.0 - Created by Headbolt
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
IFS=':' # Internal Field Seperator Delimiter is set to colon (:)
if [ $ZSH_VERSION ] # Check if shell is ZSH and if so enable IFS
	then
		setopt sh_word_split
fi
#
SSID=$(wdutil info | grep " SSID" | awk '{print $3}') # Grab latest Networking Info, and filter to get the current SSID In Use
BSSID=$(wdutil info | grep "BSSID" | awk '{print $3}') # Grab latest Networking Info, and filter to get the current BSSID In Use
#
IFS=' ' # Internal Field Seperator Delimiter is set to space ( )
unset ifs # set the IFS back to normal
#
if [ "$SSID" == "" ]
	then
		RESULT="No WiFi Data Gathered"
	else
		RESULT=$(/bin/echo "SSID = $SSID - BSSID = $BSSID")
fi
#
/bin/echo "<result>$RESULT</result>"
