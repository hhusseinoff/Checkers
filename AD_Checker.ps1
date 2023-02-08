$machineslist = (Get-Content -Path "$PSScriptRoot\Input.txt")


##----------AUTO-GET section--------------

##$AD_Data_E1_PROD = Get-ADComputer -Filter "Name -like 'XPE1-D*'" -Properties CanonicalName, Description -Server something

##then modify the foreach cycle conditions like so:

##foreach($ADObject in $AD_Data_E1_PROD)
##{
##    $machineADPath = $ADObject.CanonicalName
##
##    $machineDescription = $ADObject.Description
##
##    $machineSID = $ADObject.SID
##
##    then the output to file part with add content remains the same
##
##    Don't forget to put whatever properties you need in the -Value param for the Add-Content cmdlet
##}

##----------AUTO-GET section END--------------

    foreach($machine in $machineslist)
    {
        if($machine -like "XPE?-D?????_RD*")
        {
            $newname = $machine.Substring(0,11)

            try
            {
                $AD_Data = Get-ADComputer -Identity $newname -Properties CanonicalName, Description -Server "something" -ErrorAction Ignore

                $machineADPath = $AD_Data.CanonicalName

                $machineDescr = $AD_Data.Description

                $machineSID = $AD_Data.SID
            }
            catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
            {
                $machineADPath = "Doesn't Exist"

                $machineDescr = "Doesn't Exist"

                $machineSID = "Doesn't Exist"
            }

            $outputexists = Test-Path -Path "$PSScriptRoot\Output.txt" -PathType Leaf

            if($false -eq $outputexists)
            {
                Add-Content -Path "$PSScriptRoot\Output.txt" -Value "MachineName`tAD CanonicalPath`tAD Computer Description`tSID" 
            }

            Add-Content -Path "$PSScriptRoot\Output.txt" -Value "$newname`t$machineADPath`t$machineDescr`t$machineSID"

        }
        if($machine -like "X?E?-D?????")
        {

            try
            {
                $AD_Data = Get-ADComputer -Identity $machine -Properties CanonicalName, Description -Server wwg00m.rootdom.net -ErrorAction Ignore

                $machineADPath = $AD_Data.CanonicalName

                $machineDescr = $AD_Data.Description

                $machineSID = $AD_Data.SID
            }
            catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundException]
            {
                $machineADPath = "Doesn't Exist"

                $machineDescr = "Doesn't Exist"

                $machineSID = "Doesn't Exist"
            }

            $outputexists = Test-Path -Path "$PSScriptRoot\Output.txt" -PathType Leaf

            if($false -eq $outputexists)
            {
                Add-Content -Path "$PSScriptRoot\Output.txt" -Value "MachineName`tAD CanonicalPath`tAD Computer Description`tSID" 
            }

            Add-Content -Path "$PSScriptRoot\Output.txt" -Value "$machine`t$machineADPath`t$machineDescr`t$machineSID"
        }

    }



