function Connect_E1_Vcenters {

$passwordE1 = ConvertTo-SecureString "something" -AsPlainText -Force


$E1_VMWareCred = New-Object System.Management.Automation.PSCredential ("something_E1",$passwordE1)

Connect-VIServer -Server servername1 -Credential $E1_VMWareCred
Connect-VIServer -Server servername2 -Credential $E1_VMWareCred
Connect-VIServer -Server servername3 -Credential $E1_VMWareCred

}

function Connect_E2_Vcenters{

$passwordE2 = ConvertTo-SecureString "something" -AsPlainText -Force


$E2_VMWareCred = New-Object System.Management.Automation.PSCredential ("something_E2",$passwordE2)

Connect-VIServer -Server servername1 -Credential $E2_VMWareCred
Connect-VIServer -Server servername2 -Credential $E2_VMWareCred
Connect-VIServer -Server servername3 -Credential $E2_VMWareCred

}


$machineslist = (Get-Content -Path "$PSScriptRoot\Input.txt")

Connect_E1_Vcenters
Connect_E2_Vcenters

##---------------------------AUTO-GET section---------------------

##$allE1_INT = Get-VM -Name "XIE1-D?????"
##$allE2_INT = Get-VM -Name "XIE2-D?????"

##$AutoStoredArray = $allE1_INT + $allE2_INT


##---------------------------AUTO-GET section End---------------------

foreach($Machine in $machineslist)
{
    $VMObj = Get-VM -Name $Machine

    ##$vmOS = Get-VMGuest -VM $VMObj

    ##$vmOSName = $vmOS.OSFullName

    ##$vmosIP = $vmOS.IPAddress

    $VMname = $VMObj.Name

    $VMCoreCount = $VMObj.NumCpu

    $VMPowerState = $VMObj.PowerState

    $VMmemory = $VMObj.MemoryGB

    $vmcreated = $VMObj.CreateDate

    $vmUid = $VMObj.Uid

    $outputexists = Test-Path -Path "$PSScriptRoot\Output.txt" -PathType Leaf

    if($false -eq $outputexists)
    {
        Add-Content "$PSScriptRoot\Output.txt" -Value "VM Name`tVM Core Count`tVM Power State`tVM Memory Size`tVM Creation Date`tVM Uid"
    }

    Add-Content "$PSScriptRoot\Output.txt" -Value "$VMname`t$VMCoreCount`t$VMPowerState`t$VMmemory`t$vmcreated`t$vmUid"

    
}