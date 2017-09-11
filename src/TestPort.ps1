[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]$hostname,
    [Parameter(Mandatory=$true)]
    [int]$port
)

# This works no matter in which form we get $host - hostname or ip address
# try {
#     $ip = [System.Net.Dns]::GetHostAddresses($hostname) | 
#         select-object IPAddressToString -expandproperty  IPAddressToString
#     if($ip.GetType().Name -eq "Object[]")
#     {
#         #If we have several ip's for that address, let's take first one
#         $ip = $ip[0]
#     }
# } catch {
#     Write-Host "Possibly $hostname is wrong hostname or IP"
#     return
#}
$ip = $hostname
$t = New-Object Net.Sockets.TcpClient
# We use Try\Catch to remove exception info from console if we can't connect
try {
    $t.Connect($ip,$port)
} catch {}

if($t.Connected)
{
    $t.Close()
    # $object = [pscustomobject] @{
    #                 Hostname = $hostname
    #                 IP = $IP
    #                 TCPPort = $port
    #                 GetResponse = $True }
    # Write-Output $object
} else {
    # $object = [pscustomobject] @{
    #                 Computername = $IP
    #                 TCPPort = $port
    #                 GetResponse = $False }
    # Write-Output $object
    exit 1
}
#Write-Host $msg
#Write-Host "Error: $?"
#Write-Host "LastExitCode: $lastexitcode"