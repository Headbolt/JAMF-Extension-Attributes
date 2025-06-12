#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	ScreenConnect-Vers-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#	As an "Integer" Type so we can rference it with a Smart group as a Greater or Less than Value
#
#   - This script will ...
#		Grab the Version of a ScreenConnect app
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.1 - 12/06/2025
#
#	09/06/2025 - V1.0 - Created by Headbolt
#
#	12/06/2025 - V1.1 - Updated by Headbolt
#							Now Gives an output version of "00.00" when no version is returned, indicating Software missing
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
ScreenConnectTennantID="<tennant id>" # Sets the Tennant ID for reference
ScreenConnectAPP="<prefix name . eg ScreenConnect, or connectWisecontrol>-"$ScreenConnectTennantID".app" # Sets the App Name Prefixes and Suffixes for reference
#
ScreenConnectVersion=$(defaults read /applications/$ScreenConnectAPP/Contents/Info.plist CFBundleShortVersionString) # Get the current version of Zscaler client
#
if [[ -n "$ScreenConnectVersion" ]]
	then
		/bin/echo "<result>$ScreenConnectVersion</result>"
	else
		/bin/echo "<result>00.00</result>"
fi
