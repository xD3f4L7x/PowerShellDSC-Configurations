Configuration FileCheckCreate
{
    Import-DscResource -ModuleName "PSDesiredStateConfiguration"

    Node localhost
    {
        Script FileCheckCreate
        {
            SetScript = {
                $sw = New-Object System.IO.StreamWriter("C:\TempFolder\TestFile.txt")
                $sw.WriteLine("Testo di prova")
                $sw.Close() 
            }
            TestScript = { Test-Path "C:\TempFolder\TestFile.txt" }
            GetScript = { @{ Result = (Get-Content C:\TempFolder\TestFile.txt) } }
        }
    }
}
FileCheckCreate