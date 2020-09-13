# Althea Router Firmware
Althea.net is a software for decentralized ISPs. Prior to testing several physical routers would have to be updated with the latest firmware. The set of powershell scripts automates the process of downloading the firmware from github, setting and connecting to the proper wifi SSID (for the appropriate router), and triggering a firmware install or update.

This code remains proprietary to LunarHubLLC as a set of code examples.

# config.ps1
This file is your standard configuration file that has the global variables.

# Setup.ps1
Acts as a "main" start point to call the other powershell cmdlets.

# ConnectWifi.ps1
Connects to a wifi SSID based on several parameters.

# GetFirmware.ps1
Downloads the Althea firmware .bin file from github. Changes the name and saves it to a specific heiararchy on the system.

# InstallFirmware.ps1
Transfers the specific firmware .bin file to the router and triggers the upgrade router command.

# FindNetProfile.ps1
Uses Windows Network Profiles to connect to wifi network.