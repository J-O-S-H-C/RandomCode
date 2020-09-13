$testDate = Get-Date -Format FileDate;
$dataFile = $testDate + ".txt"
function Build-Hierarchy
{
    Param(
        [parameter(ValueFromPipeline=$true, Mandatory=$true, Position=0)]
        [String[]]
        $version,
        [parameter(ValueFromPipeline=$true, Position=1)]
        [String[]]
        $suite = "Generic"
        )

    $suiteDIR = $BASEDIR + "\" + $version + "\" + $suite;
    return $suiteDIR;
}

$path = Build-Hierarchy $VERSION
if (Test-Path -Path $path -PathType Container){
    if(Test-Path -Path ($path + "\" + $dataFile)){
        echo "---------------------------------------------";
        echo "Exported To: $path\$dataFile";
        echo "---------------------------------------------";
    }
    else
    {
        New-Item -ItemType file -Path $path -Name $dataFile;
    }
}
else
{
    New-Item -ItemType directory -Path $path;
}