#requires -version 3.0
param(
[bool]
$DevMode=$false
)

#Copy the psm1 root path into a variable for later use
$PSModuleRoot = $PSScriptRoot

#Define various hash objects
$PSL_Defined_Targets = @{}
$PSL_Logger_Instances = @{}

#PSObject containing list of module members to export at loading
$PUBLIC = New-Object psobject -Property @{
    'Function' = $( New-Object System.Collections.Generic.List[string]  )
    'Variable' = $( New-Object System.Collections.Generic.List[string]  )
    'Alias'    = $( New-Object System.Collections.Generic.List[string]  )
}

#dot source ps1 files into the modules execution context
Get-ChildItem -Path "$PSModuleRoot\scripts" -Filter "*ps1" |
Select-Object -ExpandProperty FullName |
ForEach-Object { . "$_" }

#dot source Targets.ps1 files define in the targets directory
Get-ChildItem -Path "$PSModuleRoot\targets" -Filter "*Target.ps1" |
Select-Object -ExpandProperty FullName |
ForEach-Object { . "$_" }

#add ise snippets when module is loaded
if( $Host.Name -eq 'Windows PowerShell ISE Host' ) {
    Import-IseSnippet -Path "$PSModuleRoot\Snippets"
}

$PSL_Default_Handle = New-PSLHandle -LogName 'Default'
$PSL_Logger_Instances[$PSL_Default_Handle] = $( New-PSLInstance -Name 'Default' -Path "$PSModuleRoot\Logs" )

#Export members if DevMode Export Everytrhing else export only those in the PUBLIC object
if( $DevMode ) {
    Export-ModuleMember -Function * -Variable * -Alias *
}
else {
    Export-ModuleMember -Function $PUBLIC.Function -Variable $PUBLIC.Variable -Alias $PUBLIC.Alias
}