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
#	Version: 1.0 - 09/06/2025
#
#	09/06/2025 - V1.0 - Created by Headbolt
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
ScreenConnectVersion=$(defaults read /applications/$ScreenConnectAPP/Contents/Info.plist CFBundleVersion) # Get the current version of Zscaler client
#
/bin/echo "<result>$ScreenConnectVersion</result>"
