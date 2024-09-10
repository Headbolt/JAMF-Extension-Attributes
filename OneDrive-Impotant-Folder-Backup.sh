#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	OneDrive-Impotant-Folder-Backup.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute with a Data Type of String
#
#   - This script will ...
#       Look to see if the Requested folder, is redirected into OneDrive
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
# DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################################################
#
ODFolderName="OneDrive - xxxx" # Set the OneDrive Folder Name Expected. eg OneDrive - Contoso
FolderToProcess="Desktop" # Set the Important Folder to check if redirected into OneDrive
#
UserName=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' ) # Grab Current Logged In Username
ODFolderNameTrimmed=$(echo $ODFolderName | tr -d ' ') # Construct the OneDrive Folder name with whitespaces trimmed
ODFolder="/Users/$UserName/$ODFolderName" # Construct the OneDrive Folder path
#
###############################################################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
#
FolderCheck=$(ls -n "/Users/$UserName/" | grep " $FolderToProcess" | awk '{print $9,$10,$11,$12,$13,$14}' | sed -e 's/\ *$//g') # Grab The Details of the Folder
FolderChecked="$FolderToProcess -> /Users/$UserName/Library/CloudStorage/$ODFolderNameTrimmed/$FolderToProcess"
#
if [ "$FolderCheck" == "$FolderChecked" ] # Check to see if folder is a SymLink
	then 
		/bin/echo "<result>Redirected</result>" # Output Result
fi
#
if [ "$FolderCheck" == "$FolderToProcess" ] # Check to see if Folder is an actual Real Folder
	then
		/bin/echo "<result>Not Redirected</result>" # Output Result    
fi
#
if [ "$FolderCheck" == "" ] # Check if the Folder Actually Exists at all
	then 
		/bin/echo "<result>Not Exist</result>" # Output Result   
fi
