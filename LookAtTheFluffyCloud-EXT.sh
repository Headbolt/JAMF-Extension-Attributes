#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	LookAtTheFluffyCloud-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#       Look at the the details of an iCloud Account in use
#
###############################################################################################################################################
#
# HISTORY
#
#   Version: 1.0 - 03/03/2021
#
#   - 03/03/2021 - V1.0 - Created by Headbolt
#
###############################################################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
# 
# Begin Processing
#
###############################################################################################################################################
#
for user in $(ls /Users/ | grep -v Shared); do
    if [ -d "/Users/$user/Library/Application Support/iCloud/Accounts" ]; then
        Accts=$(find "/Users/$user/Library/Application Support/iCloud/Accounts" | grep '@' | awk -F'/' '{print $NF}')
        iCloudAccts+=(${user}: ${Accts})
    fi
done
#
/bin/echo "<result>$(printf '%s\n' "${iCloudAccts[@]}")</result>" # Write Result out
