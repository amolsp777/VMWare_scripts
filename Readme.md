

# Table of references

  * <small><a href='https://github.com/amolsp777/VMWare_scripts/tree/master/Get%20Cluster%2C%20Host%20%26%20VM%20info%20and%20count'>Get Cluster, Host & VM info and count</a></small>
  * <small><a href='https://ecotrust-canada.github.io/markdown-toc/'>Generate TOC Table of Contents from GitHub Markdown or Wiki Online</a></small>
  * <small><a href='https://github.com/ekalinin/github-markdown-toc/blob/master/README.md'>gh-md-toc</a></small>


# Quick Codes 

### Connect VC(s)

``` powershell
$vCs = "VC NAME"

Foreach($VC in $VCs){

If(Test-Connection $VC -Quiet -Count 1  ){

Write-Host "Connecting to VC >> $VC" -ForegroundColor Green
$VC_Connect = Connect-VIServer $VC  -WarningAction 0  # $U -Password $P -WarningAction 0
}
Else {
    Write-Host ">>> VC is not available " -ForegroundColor Red
}
If($VC_Connect.IsConnected){

#region -----------------------------
YOUR CODE WILL BE HERE
#endregion -----------------------------

}

}

```
