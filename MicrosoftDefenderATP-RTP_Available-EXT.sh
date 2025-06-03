#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	MicrosoftDefenderATP-RTP_Available-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Grab the status of the "Real Time Protection Available"
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 03/06/2025
#
#	03/06/2025 - V1.0 - Created by Headbolt
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
IFS=':' # Internal Field Seperator Delimiter is set to forward slash (/)
if [ $ZSH_VERSION ] # Check if shell is ZSH and if so enable IFS
	then
		setopt sh_word_split
fi
#
Result=$(/usr/local/bin/mdatp health | grep "real_time_protection_available" | awk '{print $3}')
#
IFS=' ' # Internal Field Seperator Delimiter is set to space ( )
unset ifs # set the IFS back to normal
#
/bin/echo "<result>$Result</result>"
