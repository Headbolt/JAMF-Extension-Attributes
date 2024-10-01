#!/bin/zsh
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	Kickoff.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute with a Data Type of Date (YYY-MM-DD hh:mm:ss) and a name of Last Boot Time
#
#   - This script will ...
#       Look at the last boot time of the system, and convert it to a format we require.
#
###############################################################################################################################################
#
# HISTORY
#
#   Version: 1.0 - 01/10/2024
#
#   - 01/10/2024 - V1.0 - Created by Headbolt
#
###############################################################################################################################################
#
# Begin Processing
#
###############################################################################################################################################
#
BootTime=$(sysctl kern.boottime | awk -F'[= |,]' '{print $6}') # Grab Last boot time and pull out the "Epoch Time"
jamfFormattedTime=$(date -jf "%s" $BootTime +"%Y-%m-%d %T") # Reformat epoch time to the correct format for JAMF
/bin/echo "<result>$jamfFormattedTime</result>" # Output data to JAMF
