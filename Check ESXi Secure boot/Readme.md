## PowerCLI find ESXi Host BIOS or UEFI boot mode

``` powershell 

$esxs = Get-VMHost
 
foreach($esx in $esxs){
    $n = ("$($esx.name)")
    $esxcli = Get-Esxcli -VMHost $n
    $esxcli.system.settings.encryption.Get() | select @{Name="VMhost";expression={$esx.name}},Mode,RequireExecutablesOnlyFromInstalledVIBs,RequireSecureBoot #| export-csv c:\filelocation.csv
    }
    
```    

### Output

![image](https://user-images.githubusercontent.com/24545237/223200865-3cc39a9b-c3b7-4535-86d1-d6e14ebff56c.png)

