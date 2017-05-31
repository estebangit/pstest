
function Run-Query {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [String]$queryString = "select sysdate from dual"
    )
    
    begin {
        Write-Output "About to execute '$queryString'"


        ### try to load assembly, fail otherwise ###
        $Assembly = [System.Reflection.Assembly]::LoadWithPartialName("System.Data.OracleClient")
        
        if ( $Assembly ) {
            Write-Host "System.Data.OracleClient Loaded!"
        }
        else {
            Write-Host "System.Data.OracleClient could not be loaded! Exiting..."
            Exit 1
        }

        # Open connection to the Oracle Database
        $connectionString = “Data Source=esteban;User Id=esteban;Password=Passw0rd;Integrated Security=no”
        $connection = New-Object System.Data.OracleClient.OracleConnection($connectionString)
        $command = new-Object System.Data.OracleClient.OracleCommand($queryString, $connection)
        $connection.Open()
        Write-Host -ForegroundColor White "  Opening Connection to Oracle Database"
        Start-Sleep -Seconds 2
    }
    
    process {
        # Getting Data from Oracle Database
        Write-Host
        Write-Host -ForegroundColor White "  Getting Data from Oracle database"
        $Oracle_data = $command.ExecuteReader()
        Start-Sleep -Seconds 2
        
        if ($Oracle_data.read()) {
            Write-Host -ForegroundColor Green "    Connection Success"
            Write-Host
            Write-Host -ForegroundColor White "  Importing Oracle data to MOSS-List (Nyitott Incidensek)"
        } else {
            Write-Host -ForegroundColor Red "    Connection Failed"
        }
        
        # After successfuly getting the data the $Oracle_data.read() method will return to a TRUE for you. Let’s have a look at the data!
        
        foreach ($Oracle_item in $command.ExecuteReader()) {
            trap [System.SystemException] {
                $ID = $Oracle_item.GetDecimal(0).tostring()
                continue
            }
            $ID = $Oracle_item.GetDecimal(0).tostring()
        }
        
    }
    
    end {
        Write-Output "Done."
    }
}
