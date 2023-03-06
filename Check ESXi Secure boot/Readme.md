## PowerCLI find ESXi Host BIOS or UEFI boot mode

``` powershell 

$esxs = Get-VMHost
 
foreach($esx in $esxs){
    $n = ("$($esx.name)")
    $esxcli = Get-Esxcli -VMHost $n
    $esxcli.system.settings.encryption.Get() | select @{Name="VMhost";expression={$esx.name}},Mode,RequireExecutablesOnlyFromInstalledVIBs,RequireSecureBoot #| export-csv c:\filelocation.csv
    }
    
```    

