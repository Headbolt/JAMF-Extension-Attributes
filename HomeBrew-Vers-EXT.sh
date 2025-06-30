#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	HomeBrew-Vers-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#	As an "Interger" Type so we can rference it with a Smart group as a Greater or Less than Value
#
#   - This script will ...
#		Grab the Version of Homebrew if installed
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 30/06/2025
#
#	30/06/2025 - V1.0 - Created by Headbolt
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
MostRecentUser=$( defaults read /Library/Preferences/com.apple.loginwindow.plist lastUserName ) # Grab Most Recent User
#
if [[ "$(arch)" == "arm64" ]] # Check Architecture and Set Brew Partch Accordingly
	then
		BrewP="/opt/homebrew/bin/brew"
	else
		BrewP="/usr/local/bin/brew"
fi
# Determine Homebrew version and set to 00.00 if not detected
if [[ -e "${BrewP}" ]]
	then 
		RESULT=$( su - "${MostRecentUser}" -c "${BrewP} --version" | grep "Homebrew " | awk '{ print $2 }' | cut -c 3- )
		if [[ -n "$RESULT" ]]
			then
				RESULT=$RESULT
			else
				RESULT="00.00"
		fi
else
		RESULT="00.00"
fi
#
/bin/echo "<result>$RESULT</result>" # Output RESULT
