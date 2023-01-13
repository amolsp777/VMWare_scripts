
#region Clear the stored variables
Remove-Variable * -ErrorAction Ignore
#endregion

#region Provide the VC names
$vCs = "VC1" , "VC2" , "VC3"
#endregion

#region Starting the code to connect to each provided VC and get the information from each cluster & Hosts details. 

$report = @()
$datareport = @()

Foreach ($VC in $VCs) {

    If (Test-Connection $VC -Quiet -Count 1  ) {
        Write-Host "Connecting to VC >> $VC" -ForegroundColor Green
        $VC_Connect = Connect-VIServer $VC  -WarningAction 0  # $U -Password $P -WarningAction 0
    }
    Else {
        Write-Host ">>> VC is not available " -ForegroundColor Red
    }
    
    If ($VC_Connect.IsConnected) {

        $datareport = Get-Cluster -PipelineVariable cluster | Get-VMHost |
        Select-Object @{N = 'VC Name'; E = { $VC } }, 
    
        @{N = 'Cluster'; E = { $cluster.Name } }, 

        @{N = 'Host'; E = { $_.Name } },

        @{N = "Host Version"; E = { $_.version } }, 
    
        @{N = "Host Build" ; E = { $_.build } },

        @{N = 'VMs on Cluster'; E = { (Get-VM -Location $cluster).Count } },

        @{N = 'VMs on Host'; E = { (Get-VM -Location $_).Count } },
    
        @{N = 'PowerON VMs on Host'; E = { (Get-VM -Location $_ | Where-Object { $_.PowerState -eq "PoweredOn" }).Count } }, 

        @{N = 'PowerOFF VMs on Host'; E = { (Get-VM -Location $_ | Where-Object { $_.PowerState -eq "PoweredOff" }).Count } },

        @{N = 'Host CPUSocket'; E = { $_.ExtensionData.Summary.Hardware.NumCpuPkgs } },

        @{N = 'Host Corepersocket'; E = { $_.ExtensionData.Summary.Hardware.NumCpuCores / $_.ExtensionData.Summary.Hardware.NumCpuPkgs } },

        @{N = 'WindowsVM'; E = { (Get-VM -Location $_ | Where-Object { $_.Guest.OSFullName -match "Windows" }).Count } },

        @{N = 'WinVMOS'; E = { (Get-VM -Location $_ | Where-Object { $_.Guest.OSFullName -match "Windows" }).OSFullName -join '|' } }
        
        $report += $datareport
    }
}

#endregion

#region Storing the output
$report | ft
$report | Export-Csv P:\_Scripts\VMWare\Get-ClusterHostVMInfo.csv -NoTypeInformation 
#endregion
