

function Get-PSLTargetName {
    param(
    $Name="*"
    )
    
    $PSL_Defined_Targets.Keys |
    Out-String -Stream |
    Where-Object { $PSItem -like $Name } |
    Write-Output
}

#Register as Public Function to be exported  
if( Test-Path Variable:PUBLIC ) {
    $PUBLIC.Function+="$(( $MyInvocation.MyCommand.Name -replace '.ps1','' ).Trim() )"
}