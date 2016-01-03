

<#
.COMPONENT
.SYNOPSIS
.DESCRIPTION
.PARAMETER param1
.PARAMETER param2
.EXAMPLE
.INPUTS
.OUTPUTS
.LINK
#>
function Add-PSLTarget {
    param(
    [string]
    $TargetName,
    [Scriptblock]
    $TargetAction
    )

    $PSL_Defined_Targets["$TargetName"] = $TargetAction
}

Set-Alias -Name 'PSLTarget' -Value Add-PSLTarget

#Register as Public Function to be exported  
if( Test-Path Variable:PUBLIC ) {
    $PUBLIC.Function+="$(( $MyInvocation.MyCommand.Name -replace '.ps1','' ).Trim() )"
    $PUBLIC.Function+="PSLTarget"
}