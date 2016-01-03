<#
.Synopsis
   Writes Information messages to various defined targets
.DESCRIPTION
   Writes Informational log messages to the various defined targets
.PARAMETER Message
    The Log Message to record
.PARAMETER Context
    Where the Log Message was generated,
    usually the name of the function or script that called this cmdlet
.PARAMETER LogName
    The name of the Logger to use to log the message content. Defaults
    to DEFAULT
.EXAMPLE
   Write-PSLInformation -Message "Logging Information Message"
   
   this will Write Info Strings to the DEFAULT logs targets with a context of NONE
.EXAMPLE
   Write-PSLInformation -Message "Log This Info" -Context 'Add-FooBar' -LogName 'PSLogger'

   this will Write Info Strings to the PSLogger Logs targets with a context of Add-FooBar
.INPUTS
   String, String, String
.OUTPUTS
   Void
.COMPONENT
   PoshLogger
#>
function Write-PSLInformation {
    [CmdletBinding()]
    [OutputType([Void])]
    Param
    (
    [Parameter(Mandatory)]
    [ValidateNotNull()]
    [AllowEmptyString()]
    [string]
    $Message,

    [Parameter()]
    [string]
    $Context='NONE',

    [Parameter(HelpMessage='The Handle to the logger to use for this message, The handle is returned by the Start-PSLLogger, if null the Default Logger is Used')]
    [AllowNull()]
    [PSObject]
    $Handle
    )

    Begin {
      if($Handle.GetType().Name -eq 'PSLogger.LoggerHandle') {
        $Logger = $PSL_Logger_Instances[$Handle]
      } 
      else {
        $Logger = $PSL_Logger_Instances[$PSL_Default_Handle]
      }
    }

    Process {}

    End {}
}

#Register as Public Function to be exported  
if( Test-Path Variable:PUBLIC ) {
    $PUBLIC.Function+="$(( $MyInvocation.MyCommand.Name -replace '.ps1','' ).Trim() )"
}