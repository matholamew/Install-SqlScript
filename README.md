# Install-SqlScript

Runs the files that are in the directory on the server(s). Since this uses Invoke-DbaQuery, it is intended to run .sql files.

## Getting Started

Clone or download the repo.


### Prerequisites

Requires dbatools.

### Examples
    
* Install-SqlScript -Server Server1 -Database DB1 -Path "C:\temp\"
    * Runs all scripts in the Path on the Server and Database provided.
* Install-SqlScript -Server Server1 -Database DB1 -Path "C:\temp\" -Extension .sql
    * Runs all sql scripts in the Path on the Server and Database provided.
* Install-SqlScript -Server Server1,Server2 -Database DB1 -Path "C:\temp\" -Extension .sql
    * Runs all sql scripts in the Path on Server1 and Server2 and Database provided.
* Install-SqlScript -Server Server1,Server2 -Database DB1,DB2 -Path "C:\temp\" -Extension .sql
    * Runs all sql scripts in the Path on Server1 and Server2 and DB1 and DB2 provided.