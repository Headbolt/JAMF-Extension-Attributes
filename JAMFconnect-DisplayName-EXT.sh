#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	JAMFconnect-DisplayName-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Grab the current users UPN from JAMF Connect, and upload it to the Compiter Onect as the "User".
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 15/05/2025
#
#	15/05/2025 - V1.0 - Created by Headbolt
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

currentUser=$(stat -f%Su /dev/console) # Grab Current Username
# Grab JAMF Connect State for Current User
displayName=$(sudo -u "$currentUser" defaults read "/Users/$currentUser/Library/Preferences/com.jamf.connect.state" DisplayName 2>/dev/null)
#
if [[ -n "$displayName" ]]
	then
		/bin/echo "<result>$displayName</result>"
	else
		/bin/echo "<result>Not Found</result>"
fi
