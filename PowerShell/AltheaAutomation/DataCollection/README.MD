# Althea Router Firmware
Althea.net is a software for decentralized ISPs. The router firmware has an API that communicates to the exit server and other routers. There are a lot of statistics and various tests use the API data to determine Pass of Fail. This is only a small subset of data that can be pulled from the API as an example of how PowerShell was being used with Althea automation.

This code remains proprietary to LunarHubLLC as a set of code examples.

# config.ps1
This file is your standard configuration file that has the global variables.

# Data.ps1
This was a quick hack thrown together for displaying the data to manually verify tests.

# DataManager.ps1
Builds the file structure for the export of API data.