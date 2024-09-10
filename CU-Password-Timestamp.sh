#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	CU-Password-Timestamp.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute with a Data Type of Date (YYY-MM-DD hh:mm:ss) and a name of OneDrive Last Sync Timestamp
#
#   - This script will ...
#       Grab the date the current users password was set on the Local Mac
#
###############################################################################################################################################
#
# HISTORY
#
#   Version: 1.0 - 10/09/2024
#
#   - 10/09/2024 - V1.0 - Created by Headbolt
#
###############################################################################################################################################
# 
# Begin Processing
#
###############################################################################################################################################
#
USER=$(stat -f%Su /dev/console) # Get Current User Name.
# Grab the Last Password Timestamp in Raw form
RAWSTAMP=$(sudo dscl . -read /Users/$USER accountPolicyData | tail -n +2 | plutil -extract passwordLastSetTime xml1 -o - -- - | sed -n "s/<real>\([0-9]*\).*/\1/p")
STAMP=$(date -r $RAWSTAMP +"%Y-%m-%d %H:%M:%S") # Convert stamp to correct format for JAMF to read as a Date
/bin/echo "<result>$STAMP</result>" # Output Results
