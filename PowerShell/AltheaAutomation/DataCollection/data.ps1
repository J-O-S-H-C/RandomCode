. .\config.ps1
. .\dataManager.ps1


switch($EXITSERVER)
{
    borked {$exitIP = "*:e6f"}
    test {$exitIP = "*:1e0f"}
    SAmerica {$exitIP = "*:e7f"}
}

$routerDebts = curl 192.168.10.1:4877/debts | ConvertFrom-JSON
$routerInfo = curl 192.168.10.1:4877/info | ConvertFrom-JSON
$routerExits = curl 192.168.10.1:4877/exits | ConvertFrom-JSON
ForEach ($routerDebt in $routerDebts){
    if (($routerDebt.identity.mesh_ip -like $exitIP) -and ($routerDebt.payment_details.debt -gt 0)){
        $debt = $routerDebt.payment_details.debt;
    }
}
ForEach ($routerExit in $routerExits){
    if ($routerExit.exit_settings.id.mesh_ip -like $exitIP){
        $exitPrice = $routerExit.exit_settings.general_details.exit_price;
    }
}
$dataFilePath = $path + "\" + $dataFile
$dataTitle = $routerInfo.device + ": " + $routerInfo.version + ": " + $runTime + " PST";
Add-Content -Path $dataFilePath -Exclude help* -Value "-----------------"
Add-Content -Path $dataFilePath -Exclude help* -Value $dataTitle
Add-Content -Path $dataFilePath -Exclude help* -Value "-----------------"
Add-Content -Path $dataFilePath -Exclude help* -Value ( "Balance: " + $routerInfo.balance + 
                                                        ", Debt: " + $debt + 
                                                        ", Pay Threshold: " + $routerInfo.pay_threshold +
                                                        ", Close Threshold: " + $routerInfo.close_threshold)
echo "-----------------";
echo $routerInfo.device;
echo $routerInfo.version;
echo "-----------------";
echo "Balance:"; echo $routerInfo.balance;
echo "-----------------";
echo "Exit Price:"; echo $exitPrice;
echo "-----------------";
echo "Current Debt:";
if($debt -gt 0){
    echo $debt;
}else{
    echo "0";
}

echo "Pay/Close Percentage:";
[string]$percentagePC = [math]::Round((($routerInfo.pay_threshold/$routerInfo.close_threshold)*100)*-1, 2);
echo ($percentagePC + "%");

echo "Pay Threshold:"; echo $routerInfo.pay_threshold; #Triggers debt resolution
echo "Pay Ratio: ";
if($debt -gt 0){
    Add-Content -Path $dataFilePath -Exclude help* -Value ("Pay Ratio: " + $routerInfo.pay_threshold/$debt)
    echo ($routerInfo.pay_threshold/$debt);
    [string]$percentagePay = [math]::Round(($debt/$routerInfo.pay_threshold)*100, 2);
    echo ($percentagePay + "%");
}else{
    echo "0";
}
echo "Close Threshold:"; echo $routerInfo.close_threshold; #Triggers knocking down to free tier
echo "Close Out Ratio:";
if($debt -gt 0){
    $ratio = ($routerInfo.close_threshold/$debt)*-1;
    Add-Content -Path $dataFilePath -Exclude help* -Value ("Close Out Ratio: " + $ratio)
    echo (($routerInfo.close_threshold/$debt)*-1);
    [string]$percentageClose = [math]::Round((($debt/$routerInfo.close_threshold)*100)*-1, 2);
    echo ($percentageClose + "%");
}else{
    echo "0";
}