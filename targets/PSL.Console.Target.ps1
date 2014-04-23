
PSLTarget 'Console' {
    param(
    [string]
    $Level = 'Info',
    [DateTime]
    $DateTime = $( Get-Date ),
    [string]
    $Message = [string]::Empty,
    [string]
    $Context = 'NULL',
    $PSLogger
    )

    $MSG = "{0}`t[$Level] - $Message @ $Context" -f $( $DateTime.ToString("yyyy-MM-dd hh:mm:ss") )

    switch($Level) {
        'Debug' {
            Write-Host -Object $MSG -ForegroundColor Green   
        }
        'Verbose' {
            Write-Host -Object $MSG -ForegroundColor Gray
        }
        'Fatal' {
            Write-Host -Object $MSG -ForegroundColor Red
        }
        'Error' {
            Write-Host -Object $MSG -ForegroundColor Red
        }
        'Warn' {
            Write-Host -Object $MSG -ForegroundColor Yellow
        }
        'Info' {
            Write-Host -Object $MSG
        }
    }
}