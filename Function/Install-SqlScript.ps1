function Install-SqlScript {
    <#
    .SYNOPSIS
        Runs the files that are in the directory on the server(s).

    .DESCRIPTION
        Runs the files that are in the directory on the server(s). Since this uses Invoke-DbaQuery, it is intended
            to run .sql files.

        Requires dbatools.

    .PARAMETER Server
        The target SQL Server instance or instances.
    
    .PARAMETER Database
        The target database or databases.

    .PARAMETER Path
        The full path of scripts to run. Only one path is supported.

    .PARAMETER Extension
        The extension of scripts to run. Not a mandatory parameter. Only one Extension is supported.

    .EXAMPLE
        Install-SqlScript -Server Server1 -Database DB1 -Path "C:\temp\"

        Runs all scripts in the Path on the Server and Database provided.

    .EXAMPLE
        Install-SqlScript -Server Server1 -Database DB1 -Path "C:\temp\" -Extension .sql

        Runs all sql scripts in the Path on the Server and Database provided.

    .EXAMPLE
        Install-SqlScript -Server Server1,Server2 -Database DB1 -Path "C:\temp\" -Extension .sql

        Runs all sql scripts in the Path on Server1 and Server2 and Database provided.

    .EXAMPLE
        Install-SqlScript -Server Server1,Server2 -Database DB1,DB2 -Path "C:\temp\" -Extension .sql

        Runs all sql scripts in the Path on Server1 and Server2 and DB1 and DB2 provided.
    #>

    Param(
        [Parameter(Mandatory = $true, Position = 0)]
            [string[]]$Server,
        [Parameter(Mandatory = $true, Position = 1)]
            [string[]]$Database,
        [Parameter(Mandatory = $true, Position = 2)]
            [string]$Path,
        [Parameter(Mandatory = $false, Position = 3)]
            [string]$Extension   
    )

    Begin {
        #Import dbatools module.
        Import-Module dbatools;

        #Warn if not .sql extension.
        If($($Extension) -notlike "*.sql")
        {
            Write-Warning -Message "This installs using Invoke-DbaQuery. `r`nIt is intended to run a SQL script against a database. `r`nEnsure that the code in the file is valid SQL."
        }
    }

    Process {
        Try {
            #Cycle through servers.
            ForEach ($ServerInstance in $Server)
            {
                #Print server name.
                Write-Output "Server: $($ServerInstance)"

                #Cycle through databases.
                ForEach ($db in $Database)
                {
                    #Print database name.
                    Write-Output "Database: $($db)"

                    #Install each file in Path directory.
                    $files = (Get-ChildItem -path $Path -Filter "*$($Extension)" | Sort-Object)

                    #If file list is empty, throw warning and exit install loop.
                    If (!$files)
                    {
                        Write-Warning -Message "No files to install based on extension."
                        Break    
                    }

                    ForEach ($file in $files)
                    {
                        #Print file name.
                        Write-Output "File: $($file.Name)"
                        
                        #Install (run) the file.
                        #Invoke-DbaQuery -SqlInstance $ServerInstance -Database $Database -InputObject $file.FullName
                    }
                }
            }
        }
        Catch {
            $_
        }
    }

    End {
        Write-Output "Done."
    }
}