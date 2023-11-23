$query = 'SELECT NodeID, Caption, IPAddress, DNS, Description, MachineType, SysName, Status FROM Orion.Nodes'

$hostname = "SWOrionServer.com"

$username = "DOMAIN\User"

$password = ConvertTo-SecureString "pass" -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential ($username,$password)

$swissConnection = Connect-Swis -Hostname $hostname -Credential $cred

$nodes = Get-SwisData -SwisConnection $swissConnection -Query $query

$OutputExists = Test-Path -Path "$PSScriptRoot\Output_Sep1.txt"

if($false -eq $OutputExists)
{
    Add-Content -Path "$PSScriptRoot\Output_Sep1.txt" -Value "NodeID`tIPAddress`tCaption`tDNS`tDescription`tMachineType`tSysName`tStatus" -Force -Confirm:$false
}

foreach($singleNode in $nodes)
{
    $CurrentNodeID = $singleNode.NodeID
    $CurrentIPAdress = $singleNode.IPAddress
    $CurrentDNS = $singleNode.DNS
    $CurrentDescription = $singleNode.Description
    $CurrentMachineType = $singleNode.MachineType
    $CurrentSysName = $singleNode.SysName
    $CurrentStatus = $singleNode.Status


    Add-Content -Path "$PSScriptRoot\Output_Sep1.txt" -Value "$CurrentNodeID`t$CurrentIPAdress`t$CurrentDNS`t$CurrentDescription`t$CurrentMachineType`t$CurrentSysName`t$CurrentStatus" -Force -Confirm:$false


}