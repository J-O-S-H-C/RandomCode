function Get-Firmware
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

    $model = $model.ToLower()

    $downloadURL = $DEFAULT_URL + $testPhase + $testPhaseNum + "RC" + $releaseNum
    $firmwareDIR = $DEFAULT_DIR + $testPhase[0] + $testPhaseNum + "\"
    $fileName = "-RC" + $releaseNum + "-" + $testPhase[0] + $testPhaseNum + "-sysupgrade.bin"
    
    Write-Output "" ------------------- "Devices Downloaded:" ------------------- ""
    if($model -eq "all"){
        $MODEL_URLS.GetEnumerator() | ForEach-Object {
            $fileLoc = $firmwareDIR + ($_.key) + $fileName
            $requestLoc = $downloadURL + ($_.value)
            try {
                Invoke-WebRequest $requestLoc -OutFile $fileLoc
                Write-Output $_.key $fileLoc ""
            }
            catch {
                "Could not Download $_.key"
            }
        }
    }
    else{
        $fileLoc = $firmwareDIR + $model + $fileName
        $requestLoc = $downloadURL + $MODEL_URLS[$model]
        Write-Output $requestLoc
        try {
            Invoke-WebRequest $requestLoc -OutFile $fileLoc
            Write-Output $model $fileLoc ""
        }
        catch {
            "Could not Download $model"
        }
    }
    return;
}