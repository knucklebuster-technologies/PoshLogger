ipPSLTarget 'LogFile' {
    param(
    $Level,
    $DateTime,
    $Message,
    $Context,
    $PSLogger
    )

    $MSG = "{0}`t[$Level] - $Message @ $Context" -f $( $DateTime.ToString("yyyy-MM-dd hh:mm:ss") )

    if(-not ( Test-Path ( $PSLogger.FilePath ))) {
        New-Item -Path $PSLogger.FilePath -ItemType File -Force | Out-Null
    }
    Add-Content -Path $PSLogger.FilePath -Value $MSG | Out-Null
}