

# Table of references

  * <small><a href='https://pandao.github.io/editor.md/en.html#Heading%201%20link%20%20%20Heading%20link'>Editor.md</a></small>
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
