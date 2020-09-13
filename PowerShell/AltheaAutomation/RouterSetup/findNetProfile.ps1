Function Find-NetProfile 
{
    Param(
        [parameter(ValueFromPipeline=$true, Mandatory=$true, Position=0)]
        [String]
        $desiredSSID
    )

    netsh wlan show profiles | 
    Select-String "All User Profile" | 
    ForEach-Object {
        $_.Line.Split(": ")[1]
    } | 
    ForEach-Object {
        $profileName = $_
        netsh wlan show profile name=$profileName | 
        Select-String "SSID name" | 
        ForEach-Object {
            $_.Line.Split(": ")[1].Replace("`"","")
        }
    } |
    ForEach-Object {
        If($_ -eq $desiredSSID){
            return $profileName
        }
    }
}