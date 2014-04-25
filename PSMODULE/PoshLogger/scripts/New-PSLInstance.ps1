

function New-PSLInstance {
    [CmdletBinding()]
    [OutputType([PSObject])]
    param(
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    $Name,

    [ValidateScript({
        if($PSItem -eq $null) { return $true }
        if( -not ( [System.IO.Directory]::Exists($_) )) {
            try {
                [System.IO.Directory]::CreateDirectory($_) | Out-Null
            }
            catch {
                return $false
            }
        }
        return $true
    })]
    $Path,

    [string[]]
    $TargetNames=@('LogFile')
    )

    #region PSLogger CustomObject
    New-Module -AsCustomObject -ArgumentList $Name, $Path, $TargetNames -ScriptBlock {
        
        #region define Members
        $Name = "$( $args[0] )"
        $FileInfo = New-Object System.IO.FileInfo -ArgumentList "$( Join-Path -Path $args[1] -ChildPath ( $Name + '.log' ))"
        $FileInfo.Create() | Out-Null
        $FilePath = $FileInfo.FullName
        $Targets = New-Object System.Collections.Generic.List[ScriptBlock]
        #endregion

        #region Add Targets
        $args[2] | 
        ForEach-Object {
            if( $PSL_Defined_Targets.Keys -contains "$_" ) {
                $Targets.Add( $PSL_Defined_Targets["$_"] )
            }
            elseif( $PSL_Defined_Targets.Keys -contains ( "$_" + "Target" )) {
                $Targets.Add( $PSL_Defined_Targets["$( $_ + 'Target' )"] )
            }
        }
        #endregion

        #region Public Functions
        function Debug {
            param(
            $Message,
            $Context
            )
        }

        function Verbose {
            param(
            $Message,
            $Context
            )
        }

        function Fatal {
            param(
            $Message,
            $Context
            )
        }

        function Error {
            param(
            $Message,
            $Context
            )
        }

        function Warn {
            param(
            $Message,
            $Context
            )
        }

        function Info {
            param(
            $Message,
            $Context
            )

            $Targets |
            ForEach-Object {
              $PSItem.Invoke('Info', $(Get-Date), $Message, $Context, $this)
            } 
        }
        #endregion

        #export public object members
        Export-ModuleMember -Variable Name, FilePath -Function Debug, Verbose, Fatal, Error, Warn, Info
    } |
    Add-Member -MemberType ScriptMethod -Name 'GetType' -Value {
        New-Object PSObject -Property @{
            'IsPublic' = $true
            'IsSerial' = $false
            'Name'     = 'PSLogger.LoggerInstance'
            'BaseType' = 'System.Object'
        } | Format-Table -AutoSize
    } -Force -PassThru |
    Add-Member -MemberType ScriptMethod -Name 'ToString' -Value {
        Get-Content $this.FilePath | Out-String
    } -Force -PassThru
    #endregion
}