$DEFAULT_USER ="root"
$DEFAULT_FILE = "sysup.bin"

function Install-Firmware
{
    Param(
        [parameter(ValueFromPipeline=$true, Mandatory=$true, Position=0)]
        [String]
        $releaseNum,
        [parameter(ValueFromPipeline=$true, Position=1)]
        [String]
        $model,
        [parameter(ValueFromPipeline=$true, Position=2)]
        [String]
        $testPhaseNum,
        [parameter(ValueFromPipeline=$true, Position=3)]
        [String]
        $testPhase
        )

    #Building strings
    $fileName = $model + "-RC" + $releaseNum + "-" + $testPhase[0] + $testPhaseNum + "-sysupgrade.bin"
    $location = $DEFAULT_DIR + $testPhase[0] + $testPhaseNum + "\" + $fileName
    $parameterList = '-o "StrictHostKeyChecking=no" -o "PubkeyAuthentication=no"'
    $loginCredentials = $DEFAULT_USER + "@" + $DEFAULT_IP
    $serverFileLocation = "/tmp/" + $DEFAULT_FILE

    Write-Output "Secure Transfer File: $fileName to $serverFileLocation" "----------------------------------------------------------------------"

    #Transfer
    $scpArgs = $parameterList + " " + $location + " " + $loginCredentials + ":" + $serverFileLocation
    Start-Process 'C:\Windows\System32\OpenSSH\scp.exe' -Wait -ArgumentList ($scpArgs); #-NoNewWindow;
    
    Write-Output "Transfer Complete" "----------------------------------------------------------------------"
    #Execute upgrade
    $sshArgs = $parameterList + " " + $loginCredentials +  ' "sysupgrade -n ' + $serverFileLocation + '"'
    Start-Process 'C:\Windows\System32\OpenSSH\ssh.exe' -ArgumentList ($sshArgs)
    Write-Output "Upgrade Started"
    Wait-Event -Timeout 5
    netsh wlan disconnect
    return;
}