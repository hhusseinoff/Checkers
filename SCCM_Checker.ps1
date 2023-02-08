$machineslist = (Get-Content -Path "$PSScriptRoot\Input.txt")

Import-Module ConfigurationManager

##---------------------------AUTO-GET section---------------------

## Place it after cd CA1:\ or cd NA1:\ or cd NA2:\

##$E1_PROD = Get-CMDevice -Name "XPE1-D*"
##$E2_PROD = Get-CMDevice -Name "XPE1-D*"


#foreach mod example:

##comment out the machineslist section in the beginning

#PAY ATTENTION TO THE SCCM DRIVE!!

##foreach($SCCMObj in $E1_PROD)
##{
##    
##
##    do xyz
##}


##---------------------------AUTO-GET section End---------------------

$OriginalRoot = $PSScriptRoot

cd "CAS Site Code:\"

foreach($machine in $machineslist)
{
    $SCCMObj = Get-CMDevice -Name $machine

    $sccmMachineName = $SCCMObj.Name

    $sccmResourceID = $SCCMObj.ResourceID

    $sccmMAC = $SCCMObj.MACAddress

    $sccmClientType = $SCCMObj.ClientType

    $sccmClientActiveStatus = $SCCMObj.ClientActiveStatus

    $sccmClientVersion = $SCCMObj.ClientVersion

    $sccmOSBuild = $SCCMObj.DeviceOSBuild

    $sccmLastActive = $SCCMObj.LastActiveTime

    $sccmLastDDR = $SCCMObj.LastDDR

    $sccmLastPolicy = $SCCMObj.LastPolicyRequest

    $sccmLastHWinv = $SCCMObj.LastHardwareScan

    $outputexists = Test-Path -Path "$OriginalRoot\Output.txt" -PathType Leaf

    if($false -eq $outputexists)
    {
        Add-Content -Path "$OriginalRoot\Output.txt" -Value "MachineName`tResourceID`tMAC Address`tClient Type`tClient Status`tClient Version`tOSBuild`tLast Active Time`tLastDDR`tLast Policy Request`tLast HW Inventory"
    }

    Add-Content -Path "$OriginalRoot\Output.txt" -Value "$sccmMachineName`t$sccmResourceID`t$sccmMAC`t$sccmClientType`t$sccmClientActiveStatus`t$sccmClientVersion`t$sccmOSBuild`t$sccmLastActive`t$sccmLastDDR`t$sccmLastPolicy`t$sccmLastHWinv"
}

cd $OriginalRoot