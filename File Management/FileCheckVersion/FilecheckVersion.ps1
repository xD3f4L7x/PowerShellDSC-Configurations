$version = Get-Content 'version.txt'

Configuration FileCheckVersion
{
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    Node localhost
    {
        Script UpdateConfigurationVersion
        {
            GetScript = {
                $currentVersion = Get-Content (Join-Path -Path $env:SYSTEMDRIVE\Users\patrick.purpari\Desktop\ -ChildPath 'version.txt')
                return @{ 'Result' = "$currentVersion" }
            }
            TestScript = {
                # Creare e richiamare un blocco di script utilizzando la variabile automatica $GetScript, che contiene una rappresentazione di stringa di GetScript
                $state = [scriptblock]::Create($GetScript).Invoke()

                if( $state.Result -eq $using:version )
                {
                    Write-Verbose -Message ('{0} -eq {1}' -f $state.Result,$using:version)
                    return $true
                }
                Write-Verbose -Message ('Versione aggiornata: {0}' -f $using:version)
                return $false
            }
            SetScript = {
                $using:version | Set-Content -Path (Join-Path -Path $env:SYSTEMDRIVE -ChildPath 'version.txt')
            }
        }
    }
}
FileCheckVersion