#!/bin/zsh
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
#	Version: 1.1 - 12/06/2025
#
#	10/04/2025 - V1.0 - Created by Headbolt
#
#	12/06/2025 - V1.1 - Updated by Headbolt
#							Now Allows for No user logged into the Mac, which would otherwise
#							return a status of NOT Protected
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
CurrentUser=$(stat -f%Su /dev/console) # Grab Current Username
#
if [ "$CurrentUser" != "root" ]
	then
		PROCESS="ZscalerTunnel"
		ProcessRunning=$(pgrep -x $PROCESS)    
		#
		if [ "$ProcessRunning" != "" ]
			then
				/bin/echo '<result>Protected</result>'
			else 
			/bin/echo '<result>NOT Protected</result>'
		fi
	else
		ZScalerVersion=$(sudo defaults read /Applications/Zscaler/Zscaler.app/Contents/Info.plist CFBundleShortVersionString) # Get the current version of Zscaler client
		#
		if [[ -n "$ZScalerVersion" ]]
			then
				/bin/echo "<result>Installed</result>"
		fi
fi
