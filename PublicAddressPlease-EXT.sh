#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	PublicAddressPlease-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Determine the devices Public IP
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 17/01/2025
#
#	17/01/2025 - V1.0 - Created by Headbolt
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
myIP=$(curl -L -s --max-time 10 http://checkip.dyndns.org | egrep -o -m 1 '([[:digit:]]{1,3}.){3}[[:digit:]]{1,3}') # Grab Current Public IP
/bin/echo "<result>$myIP</result>" # Output Public IP
