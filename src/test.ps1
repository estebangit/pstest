# test.ps1 - version 1.0

Function Add-Folder {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$folder
    )
    
    if ( -Not (Test-Path -Path $folder )) {
        New-Item -ItemType directory -Path $folder
        Write-Output "Folder added '$folder'"
    } else {
        Write-Output "Folder already exists '$folder'"
    }
}


Function Add-DataFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$file
    )
    
    if ( -Not (Test-Path -Path $file )) {
        # New-Item -ItemType File -Path $file
        Set-Content -Path $file -Value "Sample contenent for $file"
        Write-Output "File added '$file'"
    } else {
        Write-Output "File already exists '$file'"
    }
}


# Start of the script
Write-Output "Starting ...."

$testFolder = "./tst"
$dataFolder = "$testFolder/data"

Add-Folder -folder $testFolder
Add-Folder -folder $dataFolder

for ($i = 0; $i -lt 5; $i++) {
    Add-DataFile -file "$dataFolder/test0$i.txt"
}

Write-Output "Done!"
