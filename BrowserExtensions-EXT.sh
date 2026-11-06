#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	BrowserExtensions-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attribute
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Grab the installed Browser Extensions, initially just for Edge and Chrome
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 06/11/2026
#
#	- 06/11/2026 - V1.0 - Created by Headbolt
#
###############################################################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
###############################################################################################################################################
#
declare -a Edge_Extensions # Set Up the Edge Extensions Vairable
declare -a Chrome_Extensions # Set Up the Chrome Extensions Vairable
#
###############################################################################################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
###############################################################################################################################################
#
# Defining Functions
#
###############################################################################################################################################
#
# Process Browser Function
#
Process_Browser() { # Function to inventory extensions for a specified Chromium-based browser
	local browser_name="$1" # Browser display name (e.g. Edge or Chrome)
	local browser_path="$2" # Browser profile folder name used within ~/Library/Application Support
	#
	while IFS= read -r manifest # Search all user profiles for extension manifest files
		do
			name=$(sed -n 's/^[[:space:]]*"name"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$manifest" | head -1) # Extract the extension name from the manifest.json file
			#
			[[ -z "$name" ]] && continue # Skip entries where no extension name could be determined
			#
			case "$name" in # Exclude known system/browser extensions or unresolved localisation strings
				"__MSG_"*)
					continue
					;;
				"Edge relevant text changes")
					continue
					;;
			esac
			#
			if [[ "$browser_name" == "Edge" ]] # Store the extension name in the appropriate browser array
				then
					Edge_Extensions+=("$name")
				else
					Chrome_Extensions+=("$name")
			fi
			#
	done < <(
		find /Users -type f -path "*/${browser_path}/*/Extensions/*/*/manifest.json" 2>/dev/null # Locate extension manifest files beneath all user profiles
	)
}
###############################################################################################################################################
#
# End Of Function Definition
#
###############################################################################################################################################
#
# Beginning Processing
#
###############################################################################################################################################
#
Process_Browser "Edge" "Microsoft Edge" # Inventory Microsoft Edge extensions
Process_Browser "Chrome" "Google/Chrome" # Inventory Google Chrome extensions
#
# Count unique extensions found for each browser
Edge_Count=$(printf '%s\n' "${Edge_Extensions[@]}" | sort -u | grep -c .)
Chrome_Count=$(printf '%s\n' "${Chrome_Extensions[@]}" | sort -u | grep -c .)
#
Output=""
#
if [[ "$Edge_Count" -gt 0 ]] # Build Edge section if Edge extensions were discovered
	then
		Edge_List=$(printf '%s\n' "${Edge_Extensions[@]}" | sort -u | sed 's/^/    /') # Create a deduplicated, indented list of Edge extensions
		#
		Output="Edge = $Edge_Count Extensions
$Edge_List" # Store formatted Edge results
fi
#
if [[ "$Chrome_Count" -gt 0 ]] # Build Chrome section if Chrome extensions were discovered
	then
		Chrome_List=$(printf '%s\n' "${Chrome_Extensions[@]}" | sort -u | sed 's/^/    /')
		#
		if [[ -n "$Output" ]] # Add a blank line between browser sections when both exist
			then
				Output="${Output}

"
		fi
		#
		Output="${Output}Chrome = $Chrome_Count Extensions
$Chrome_List" # Append Chrome results to the output
fi
#
if [[ -z "$Output" ]] # Return a friendly message if no extensions were found in either browser
	then
		Output="No Extensions Found"
fi
#
/bin/echo "<result>$Output</result>"
