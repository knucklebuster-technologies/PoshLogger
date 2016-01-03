function New-PSLLogCollection {
    [CmdletBinding()]
    [OutputType([System.Collections.ObjectModel.ObservableCollection[PSObject]])]
    Param ()

    $observable = New-Object System.Collections.ObjectModel.ObservableCollection[PSObject]
    $eventSub = Register-ObjectEvent -InputObject $observable -EventName CollectionChanged -Action { 
        if($Event.SourceEventArgs.Action -eq 'Add') {
            $Event.SourceEventArgs.NewItems |
            ForEach-Object {
                Write-Host $_
                $Event.Sender.Remove($_) | Out-Null
            }
        }
    }
    return $observable
}