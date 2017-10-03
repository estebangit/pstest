# Test collections v1.0
# Based on https://www.red-gate.com/simple-talk/sysadmin/powershell/powershell-one-liners-collections-hashtables-arrays-and-strings/


function Test-Array {
    [CmdletBinding()]
    param (
    )
    Write-Host "Array ..."
    $tab = @('un','deux','trois','quatre')
    $tab | ForEach-Object { "  Tab $_" }
    $tabToAdd = @("cinq","six")
    $tab = $tab + $tabToAdd
    $tab += "sept"
    "  $tab"
    $tab | Sort-Object
    Write-Host "Array !!!"
}

function Test-List {
    [CmdletBinding()]
    param (
    )
    Write-Host "List ..."
    Write-Host "List !!!"
}

function Test-Map {
    [CmdletBinding()]
    param (
    )
    Write-Host "Map ..."
    $map = @{
        "nom"="toto" 
        "prenom"="titi"
    }
    "  Map " + $map['nom']
    "  Map " + $map.nom
    Write-Host "Map !!!"
}


# run tests
Write-Host 'Start'
Test-Array
#Test-List
Test-Map
Write-Host 'Done'