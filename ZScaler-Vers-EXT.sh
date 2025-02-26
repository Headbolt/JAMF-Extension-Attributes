#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	ZScaler-Vers-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#	As an "Interger" Type so we can rference it with a Smart group as a Greater or Less than Value
#
#   - This script will ...
#		Grab the Version of Zscaler.app
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 26/02/2025
#
#	26/02/2025 - V1.0 - Created by Headbolt
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
ZScalerVersion=$(defaults read /applications/Zscaler/Zscaler.app/Contents/Info.plist CFBundleShortVersionString) # Get the current version of Zscaler client
#
/bin/echo "<result>$ZScalerVersion</result>"
