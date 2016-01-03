
<#
.COMPONENT
    PSLogger
.SYNOPSIS
    This will setup a logger with the specified parameters.
.DESCRIPTION
    This function checks if a logger with the same name already exists. If the logger is not create
    a new instance is created and stored. If the -Default switch was used We either mark the new logger as default
    of the existing one if found. If we find a logger by name and its already default if specified a warning will be emitted.
.PARAMETER Name
    The name of the logger. Used to store it in memory and if the LogFile Target is specified the name is used with a .log
    extension for the file name.
.PARAMETER TargetNames
    An array of valid target names to be executed when event log events happen. Targets are defined in the targets directory
    in the Target.ps1 files 3 predefined tatgets exist Console, LogFile, EventLog which handle Console Logging, Writting Messages to Files
    and Creating Events in Windows Application Event Log. Valid Target Names are Found in variable PSL_Available_Target_Names.
    You can create and define your own targets and include them.
.EXAMPLE
.INPUTS
.OUTPUTS
.LINK
#>
function Set-PSLDefault {
    [CmdletBinding()]
    param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [String]
    $LogName
    )

    PROCESS {
        if( $PSL_Logger_Instances.Keys -contains $LogName ) {
            $PSL_Logger_Instances["DEFAULT"] = $PSL_Logger_Instances["$LogName"]
        }
        else {
            $PSL_Logger_Instances["DEFAULT"].Warn("$LogName not Defined, DEFAULT Log has not changed","Set-PSLDefault")
        }
    }
}

#Register as Public Function to be exported  
if( Test-Path Variable:PUBLIC ) {
    $PUBLIC.Function+="$(( $MyInvocation.MyCommand.Name -replace '.ps1','' ).Trim() )"
}