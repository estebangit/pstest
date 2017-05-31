# rest.ps1 V1.0

# Bonne pratique, force l'init des variables
Set-PSDebug -Strict 

[String]$publicUri = 'https://jsonplaceholder.typicode.com/users'


Function Get-SimplePublicRest {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$uri
    )
    $headers = @{}
    Invoke-RestMethod -Method GET -Headers $headers -Uri $uri 
}


# use at your own risks ...
Function Ignore-SelfSignedCerts {
    try {

        Write-Host "Adding TrustAllCertsPolicy type." -ForegroundColor White
        Add-Type -TypeDefinition  @"
        using System.Net;
        using System.Security.Cryptography.X509Certificates;
        public class TrustAllCertsPolicy : ICertificatePolicy
        {
             public bool CheckValidationResult(
             ServicePoint srvPoint, X509Certificate certificate,
             WebRequest request, int certificateProblem)
             {
                 return true;
            }
        }
"@

        Write-Host "TrustAllCertsPolicy type added." -ForegroundColor White

    } catch {
        Write-Host $_ -ForegroundColor "Yellow"
    }

    [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
}


# Start

Write-Host "USERS 10 items"
Get-SimplePublicRest -uri $publicUri | Format-Table

#Write-Host "TODOS 200 items"
#Get-SimplePublicRest -uri "https://jsonplaceholder.typicode.com/todos" | Format-Table


# http://www.groupkt.com/post/f2129b88/free-restful-web-services-to-consume-and-test.htm
Write-Host "Countries"
$response = Get-SimplePublicRest -uri "http://services.groupkt.com/country/get/all"
#$response.RestResponse.result | Format-Table
$($response.RestResponse.result) | ForEach-Object {
    Write-Host "NAME: $($_.name), CODE2: $($_.alpha2_code), CODE3: $($_.alpha3_code)"
}