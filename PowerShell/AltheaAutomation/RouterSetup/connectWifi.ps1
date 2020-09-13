$DEFAULT_TIME = 3

function Connect-Wifi {
    Param(
        [parameter(ValueFromPipeline=$true, Mandatory=$true, Position=0)]
        [String]
        $desiredSSID,
        [parameter(ValueFromPipeline=$true, Position=1)]
        [Int16]
        $time = $DEFAULT_TIME
    )
    
    $currentSSID = netsh wlan show interfaces | Select-String -NotMatch BSSID | Select-String SSID | ForEach-Object {$_.Line.Split(": ")[1]}
    $currentProfile = netsh wlan show interfaces | Select-String -NotMatch Connection | Select-String Profile | ForEach-Object {$_.Line.Split(": ")[1]}
    $connectionState = netsh interface show interface Wi-Fi | Select-String "Connect state" | ForEach-Object {$_.Line.Split(": ")[1].Replace(" ","")}
    $ExistSSID = netsh wlan show networks | Select-String SSID | ForEach-Object {$_.Line.Split(": ")[1]}

    If($ExistSSID -eq $desiredSSID){
        $desiredProfile = Find-NetProfile $desiredSSID
    }
    elseif ($ExistSSID -eq $DEVICE_DEFAULT_SSID) {
        Write-Output "$desiredSSID not broadcasting. Failing over to default AltheaHome-5."
        $desiredSSID = $DEVICE_DEFAULT_SSID
        $desiredProfile = Find-NetProfile $desiredSSID
    }
    else {
        Write-Output "$desiredSSID and AltheaHome-5 are not broadcasting."
        return}

    If($currentSSID -ne $desiredSSID -and $currentProfile -ne $desiredProfile){
        If($time -gt $DEFAULT_TIME){
            Write-Output "Waiting $time seconds"
            Wait-Event -Timeout $time
        }
        If($connectionState -eq "Connected"){
            Write-Output "Disconnecting: $currentSSID"
            netsh wlan disconnect
        }
        Write-Output "Connecting: $desiredSSID"
        netsh wlan connect name=$desiredProfile
        Wait-Event -Timeout 3
    }
    else {
        Write-Output "$desiredSSID already connected"
    }
    return;
}