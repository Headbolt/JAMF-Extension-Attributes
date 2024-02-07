#!/bin/bash
#
###############################################################################################################################################
#
# ABOUT THIS PROGRAM
#
#	ScoobyDoo-EXT.sh
#	https://github.com/Headbolt/JAMF-Extension-Attributes
#
#   This Script is designed for use in JAMF as an Extension Attribute
#
#   - This script will ...
#		Approximate the location of a device based on its Public IP
#
###############################################################################################################################################
#
# HISTORY
#
#	Version: 1.0 - 01/03/2017
#
#	01/03/2017 - V1.0 - Created by Headbolt
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
myLocationInfo=$(curl -L -s --max-time 10 http://ip-api.com/csv/?fields=country,city,lat,lon,/$myIP) # Use Current IP to Grab IP Address Registered Location
/bin/echo "<result>$myIP - $myLocationInfo</result>" # Output Public IP and Location
