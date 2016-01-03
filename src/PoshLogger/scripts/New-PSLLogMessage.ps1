
function New-PSLLogMessage {
    [CmdletBinding()]
    [OutputType([PSObject])]
    Param (
    [ValidateSet('Debug','Verbose','Fatal','Error','Warning','Information')]
    $LogLevel='Information',
    [ValidateNotNullOrEmpty()]
    [string]
    $Message,
    [string]
    $Context='None'
    )

    PROCESS { 
        $lmObj = New-Object -TypeName PSObject -Property $PSBoundParameters
        $lmObj.PSTypeNames.Add('PoshLogger.LogMessage')
        return $lmObj
    }
}