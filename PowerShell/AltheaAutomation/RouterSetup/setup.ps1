. .\config.ps1

If($DEFAULT_MODEL -eq "all"){#downloads all from github
    Connect-Wifi $INTERNET_SSID
    If(Test-Connection -TargetName $INTERNET_IP -IPv4 -Count 1 -Quiet){
        Get-Firmware $TEST_RELEASE_NUM $DEFAULT_MODEL $TEST_PHASE_NUM $TEST_PHASE
        Exit
    }
}

$location = $DEFAULT_DIR + 
            $TEST_PHASE[0] + $TEST_PHASE_NUM + "\" + 
            $DEFAULT_MODEL + "-RC" + $TEST_RELEASE_NUM + "-" +
            $TEST_PHASE[0] + $TEST_PHASE_NUM + 
            "-" + $INSTALL_TYPE
$WifiProfile = "AltheaHome" + $DEVICE_NUM + $DEVICE_NUM
$fileExists = Test-Path -Path $location -PathType leaf

If(!$fileExists){#Downloads single device .bin from github
    Connect-Wifi $INTERNET_SSID
    If(Test-Connection -TargetName $INTERNET_IP -IPv4 -Count 1 -Quiet){
        Get-Firmware $TEST_RELEASE_NUM $DEFAULT_MODEL $TEST_PHASE_NUM $TEST_PHASE
    }
    else {
        Write-Output "No Internet Connection"
        Exit
    }
}

Connect-Wifi $WifiProfile
If(Test-Connection -TargetName $DEVICE_IP -IPv4 -Count 1 -Quiet){#uploads and installs to device
    Install-Firmware $TEST_RELEASE_NUM $DEFAULT_MODEL $TEST_PHASE_NUM $TEST_PHASE
}
else {
    Write-Output "No Network Connection"
    Exit
}

#Wait for device to install before attempting connection
Connect-Wifi $DEVICE_DEFAULT_SSID 150