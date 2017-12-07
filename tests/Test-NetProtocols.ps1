$Servers = ("google.com","80"),  ("8.8.8.8","53"),  ("8.8.4.4","53")
$Path = "D:\NETDATA\logs\Test-Protocols.csv"

CLS

DO{
    foreach($Server in $Servers)
    {
        $DateTime = Get-Date
        $ComputerName = $Server[0]
        $Port = $Server[1]

        $Test = Test-NetConnection -Port $Port -ComputerName $ComputerName -ErrorAction SilentlyContinue | Select-Object ComputerName, RemoteAddress, PingSucceeded, TcpTestSucceeded, RemotePort
        $IP = Invoke-RestMethod http://ipinfo.io/json

        IF($Test -eq $null){
            $Test.TcpTestSucceeded = "Test Failed"
            $Test.RemotePort = "Test Failed"
            $Test.ComputerName = "Test Failed"
            $Test.RemoteAddress = "Test Failed"
        }

        $Output = [PSCustomObject] @{
            TcpTestSucceeded = $Test.TcpTestSucceeded
            RemotePort = $Test.RemotePort
            ComputerName = $Test.ComputerName
            RemoteAddress = $Test.RemoteAddress
            Year = $DateTime.Year
            Month = $DateTime.Month
            Day = $DateTime.Day
            Time = $DateTime.TimeOfDay
            DateTime = $DateTime
            External_IP = $IP.ip
            External_Org = $IP.org
        }

        Export-Csv -InputObject $Output -Append -Path $Path -NoTypeInformation
        Start-Sleep -Seconds 15
    }
}
while ( $true )
