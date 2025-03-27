#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	XCodeLicense-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Determine the version of the XCode User License Agreed to
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 27/03/2025
#
#	27/03/2025 - V1.0 - Created by Headbolt
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
License=$(sudo defaults read "/Library/Preferences/com.apple.dt.Xcode.plist" IDEXcodeVersionForAgreedToGMLicense 2>/dev/null)
#
if [[ -n "$License" ]]; then
    echo "<result>$License</result>"
else
    echo "<result>0</result>"
fi
