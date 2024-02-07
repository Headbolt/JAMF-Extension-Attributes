#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	ZeroRenameName-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Grab the Machines name locally.
#		Grab the Machines Serial Number locally.
#		Use a Prefix set in a variable
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 09/02/2023
#
#	09/02/2023 - V1.0 - Created by Headbolt
#
###############################################################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################################################
#
# Variables used by this script.
#
Prefix="COMP-" # Sets the Prefix
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
CurrentName=$(scutil --get ComputerName) # This gets the Mac's current name
Serial=$(system_profiler SPHardwareDataType | grep "Serial Number" | awk '{print $4}') # This gets the Mac's Serial Number
NewName="$Prefix$Serial"
#
if [[ "$CurrentName" == "$NewName" ]] 
	then
		result='YES'
	else
		result='NO'
fi
#
/bin/echo "<result>$result</result>"
