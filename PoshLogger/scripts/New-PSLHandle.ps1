


function New-PSLHandle {
  param(
    [Parameter(Mandatory)]
    [string]
    $LogName
  )

  New-Object PSObject -Property @{
      'LogName' = "$LogName"
      'LogGUID' = $( [System.Guid]::NewGuid() )
    }  |
  Add-Member -MemberType ScriptMethod -Name 'GetType' -Value {
   New-Object PSObject -Property @{
      'IsPublic' = $true
      'IsSerial' = $false
      'Name'     = 'PSLogger.LoggerHandle'
      'BaseType' = 'System.Object'
    }
  } -Force -PassThru |
  Add-Member -MemberType ScriptMethod -Name 'ToString' -Value {
    Write-Output "PSLogger.LoggerHandle"
  } -Force -PassThru
}