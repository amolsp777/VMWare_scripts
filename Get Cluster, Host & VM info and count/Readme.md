## Purpose 

This script is to get the Cluster, Host and VMs information and VM counts on each cluster and ESXi Host.

You will get

Powered on VMs on each cluster.

Powered on VMs on each Host.

Powered on VMs count

Host version and Build number details

VM cluster

Cluster name in each VC

#### Code

```powershell
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
```


#### Output

``` powershell 
VC Name Cluster       Host   Host Version Host Build VMs on Cluster VMs on Host PowerON VMs on Host PowerOFF VMs on Host Host CPUSocket
------- -------       ----   ------------ ---------- -------------- ----------- ------------------- -------------------- --------------
VC1     VC1_Cluster_1 Host1  7.0.3        20328353   338            56          56                  0                    2
VC1     VC1_Cluster_1 Host2  7.0.3        20328353   338            64          64                  0                    2
VC1     VC1_Cluster_2 Host3  7.0.3        20328353   12             1           1                   0                    2
VC1     VC1_Cluster_2 Host4  7.0.3        20328353   12             2           1                   1                    2
VC2     VC2_Cluster_1 Host5  7.0.3        20328353   338            57          57                  0                    2
VC2     VC2_Cluster_1 Host6  7.0.3        20328353   338            64          64                  0                    2
VC2     VC2_Cluster_2 Host7  7.0.3        20328353   12             9           8                   1                    2
VC2     VC2_Cluster_2 Host8  7.0.3        20328353   12             1           1                   0                    2
VC3     VC3_Cluster_1 Host9  7.0.3        20328353   12             2           1                   1                    2
VC3     VC3_Cluster_1 Host10 7.0.3        20328353   16             11          11                  0                    2
VC3     VC3_Cluster_2 Host11 7.0.3        20328353   16             4           4                   0                    2
VC3     VC3_Cluster_2 Host12 7.0.3        20328353   16             1           1                   0                    2

```
