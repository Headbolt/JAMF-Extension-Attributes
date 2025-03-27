#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	XCodeLicenseVersionCompare-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Determine the version of App installed, if present
#		Determine the version of the XCode User License Agreed to
#		Compare the 2 and give output useable in SmartGroups
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
XcodeVers=$(defaults read "/Applications/xcode.app"/Contents/version CFBundleShortVersionString 2>/dev/null) # Extracts the Version from the APP
if [[ -n "$XcodeVers" ]] # Check result, if blank set it to 0
	then
		/bin/echo "App Ver = $XcodeVers"
	else
		XcodeVers="0"
fi
#
License=$(sudo defaults read "/Library/Preferences/com.apple.dt.Xcode.plist" IDEXcodeVersionForAgreedToGMLicense 2>/dev/null) # Extracts License Version
if [[ -n "$License" ]] # Check result, if blank set it to 0
	then
		/bin/echo "License Ver = $License"
	else
		License="0"
fi
#
if [[ "$XcodeVers" == "0" ]]
	then
    	/bin/echo '<result>App Missing</result>'
	else
		if [[ "$License" == "0" ]]
			then
				/bin/echo '<result>License Missing</result>'
			else
				if [[ "$License" < "$XcodeVers" ]]
					then
						/bin/echo '<result>License Update Needed</result>'
					else
						/bin/echo '<result>License Matches App</result>'
				fi
		fi
fi
