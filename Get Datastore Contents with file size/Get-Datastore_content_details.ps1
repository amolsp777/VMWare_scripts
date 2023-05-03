@"
===============================================================================
Title:         DataStore_Content_details.ps1
Description:   Pull DataStore Contents details from mentioned vCenters and datastores. 
Usage:         .\VC-AlarmCheck_Report.ps1
Date:          05/03/2023
Author:        Amol Patil
Verion:        v1.0
===============================================================================
"@



$vCs = "VC name" #, 


Foreach ($VC in $VCs) {

If(Test-Connection $VC -Quiet -Count 1){

Write-Host " Connecting to VC >> $VC" -ForegroundColor Green
$VC_Connect = Connect-VIServer $VC -WarningAction 0 #$U -Password $P -WarningAction 0}

}

Else {
    Write-Host " >>> VC is not available " -ForegroundColor Red
}
If ($VC_Connect.IsConnected){

$dsName = "Datastore name"

$j = 0
Foreach ($DatastoreN in $dsName) {

$j++
Write-Progress -Id 1 -activity "Processing for Datastore . . ." -status "DS Checked: $j of $($dsName.Count)" -percentComplete (($j / $dsName.Count)  * 100)

$ds = Get-Datastore -Name $DatastoreN

New-PSDrive -Name TgtDS -Location $ds -PSProvider VimDatastore -Root '\' | Out-Null

$GCI = Get-ChildItem -Path TgtDS: -Recurse | where{$_.ItemType -ne "Folder"} #| select * -First 5  #Name,DatastoreFullPath,LastWriteTime

$infoColl = @()

$i = 0

Foreach ($file in $GCI){
$i++
Write-Progress -ParentId 1 -activity "Processing for file . . ." -status "Checked: $i of $($GCI.Count)" -percentComplete (($i / $GCI.Count)  * 100)

$fSize = ($file | Measure-Object -Sum Length).Sum / 1MB

$infoObject = New-Object PSObject
		#The following add data to the infoObjects.	
		Add-Member -inputObject $infoObject -memberType NoteProperty -name "Datastore" -value $file.Datastore
Add-Member -inputObject $infoObject -memberType NoteProperty -name "File name" -value $file.name
Add-Member -inputObject $infoObject -memberType NoteProperty -name "ItemType" -value $file.ItemType
Add-Member -inputObject $infoObject -memberType NoteProperty -name "Size(MB)" -value $fSize
Add-Member -inputObject $infoObject -memberType NoteProperty -name "FolderPath" -value $file.FolderPath
Add-Member -inputObject $infoObject -memberType NoteProperty -name "DatastoreFullPath" -value $file.DatastoreFullPath
Add-Member -inputObject $infoObject -memberType NoteProperty -name "LastWriteTime" -value $file.LastWriteTime

		$infoColl += $infoObject

}
$infoColl | Export-Csv -Path $PSScriptRoot\DS_contentdetails_$($DatastoreN).csv -NoTypeInformation

Remove-PSDrive -Name TgtDS

}


}

}


