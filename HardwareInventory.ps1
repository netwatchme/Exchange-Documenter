Function Global:Get-HardwareInventory {
  PARAM ($CRLF = ";;")
  PROCESS {
    $obj = New-Object PSObject
    $ComputerName = $_.trimend()

    $results = Get-WMIObject -query "select StatusCode from Win32_PingStatus where Address = '$ComputerName'"
    if ($results.statuscode -eq 0) {

      $ID = 9185476
      write-progress -ID $ID -activity $ComputerName -status "Win32_ComputerSystem" -percentcomplete 0
      $obj | Add-Member NoteProperty NewRecord $ComputerName
      $wmi = Get-WmiObject Win32_ComputerSystem -Namespace “root\CIMV2" -ComputerName $ComputerName 
      $obj | Add-Member NoteProperty ComputerManufacturer ($wmi.Manufacturer)
      $obj | Add-Member NoteProperty ComputerModel ($wmi.Model)
      $obj | Add-Member NoteProperty TotalMemory ([math]::truncate($wmi.TotalPhysicalMemory / 1MB))
      $obj | Add-Member NoteProperty ProcessorCount ($wmi.NumberOfProcessors)

      write-progress -ID $ID -activity $ComputerName -status "Win32_OperatingSystem" -percentcomplete 10
      $wmi = Get-WmiObject Win32_OperatingSystem –comp $ComputerName 
      $obj | Add-Member NoteProperty OSName ($wmi.Name)
      $obj | Add-Member NoteProperty BuildNumber ($wmi.BuildNumber)
      $obj | Add-Member NoteProperty CSName ($wmi.CSName)
      $obj | Add-Member NoteProperty OSVersion ($wmi.Version)
      $obj | Add-Member NoteProperty SPVersion ($wmi.ServicePackMajorVersion)

      write-progress -ID $ID -activity $ComputerName -status "Win32_BIOS" -percentcomplete 20
      $wmi = Get-WmiObject Win32_BIOS –comp $ComputerName 
      $obj | Add-Member NoteProperty BIOS ($wmi.Description)
      $obj | Add-Member NoteProperty BIOSVersion ($wmi.SMBIOSBIOSVersion+"."+$wmi.SMBIOSMajorVersion+"."+$wmi.SMBIOSMinorVersion)
      $obj | Add-Member NoteProperty BIOSSerial ($wmi.SerialNumber)

      write-progress -ID $ID -activity $ComputerName -status "Win32_Processor" -percentcomplete 30
      $wmi = Get-WmiObject Win32_Processor -Namespace “root\CIMV2" -Computername $ComputerName 
      $wmi | % {
        $CPUID += $_.DeviceID+$CRLF
        $CPUName += $_.Name+$CRLF
        $CPUCaption += $_.Caption+$CRLF
        $CPUCores += [string]$_.NumberOfCores+$CRLF
        $CPUSpeed += [String]$_.MaxClockSpeed+$CRLF
      }
      $obj | Add-Member NoteProperty ProcessorCores ($CPUCores)
      $obj | Add-Member NoteProperty ProcessorDeviceID ($CPUID)
      $obj | Add-Member NoteProperty ProcessorName ($CPUName)
      $obj | Add-Member NoteProperty ProcessorCaption ($CPUCaption)
      $obj | Add-Member NoteProperty ProcessorSpeed ($CPUSpeed)

      write-progress -ID $ID -activity $ComputerName -status "Win32_DiskDrive" -percentcomplete 40
      $wmi = Get-WmiObject Win32_DiskDrive -Namespace “root\CIMV2" -ComputerName $ComputerName 
      $wmi | % {
        $DiskDeviceID += $_.DeviceID+$CRLF
        $DiskSize += [string]([math]::truncate($_.size / 1GB))+$CRLF
        $DiskDescription += $_.Description+$CRLF
        $InterfaceType += $_.InterfaceType+$CRLF
        $MediaType += $_.MediaType+$CRLF
      }
      $obj | Add-Member NoteProperty Disk $DiskDeviceID
      $obj | Add-Member NoteProperty Size $DiskSize
      $obj | Add-Member NoteProperty DiskDescription $DiskDescription
      $obj | Add-Member NoteProperty DriveType $InterfaceType
      $obj | Add-Member NoteProperty MediaType $MediaType

      write-progress -ID $ID -activity $ComputerName -status "Win32_LogicalDisk" -percentcomplete 50
      $wmi = Get-WmiObject Win32_LogicalDisk -Namespace “root\CIMV2" -ComputerName $ComputerName
      $wmi | % {
        $LogicalDrives += $_.DeviceID+$CRLF
        $LogicalDriveSize += [string]([math]::truncate($_.size / 1GB))+$CRLF
        $FreeSpace += [string]([math]::truncate($_.FreeSpace / 1GB))+$CRLF
        $VolumeName += $_.VolumeName+$CRLF
      }
      $obj | Add-Member NoteProperty LogicalDrives $LogicalDrives
      $obj | Add-Member NoteProperty VolumeName $VolumeName
      $obj | Add-Member NoteProperty LogicalDriveSize $LogicalDriveSize
      $obj | Add-Member NoteProperty DriveFreeSpace $FreeSpace

      write-progress -ID $ID -activity $ComputerName -status "Win32_NetworkAdapterConfiguration" -percentcomplete 60
      $wmi = Get-WmiObject Win32_NetworkAdapterConfiguration -Namespace “root\CIMV2" -ComputerName $ComputerName | where{$_.IPEnabled -eq “True”}
      $wmi | % {
        $NICDesc += $_.Description + $CRLF
        $NICDHCP += @(if ($_.DHCPEnabled) {"Yes"} else {"No"}) +$CRLF
        $NICIP += [string]::join(";",$_.IPAddress) +$CRLF
        $NICSubnet += [string]::join(";",$_.IPSubnet) +$CRLF
        $NICGateway += [string]::join(";",$_.DefaultIPGateway) +$CRLF
        $NICMAC += $_.MACAddress +$CRLF
        $NICDNS += [string]::join(";",$_.DNSServerSearchOrder) +$CRLF
        $NICWINS1 += $_.WINSPrimaryServer +$CRLF
        $NICWINS2 += $_.WINSSecondaryServer +$CRLF
      }
      $NICCount = 1
      if ($wmi.count -gt 0) { $NICCount = $wmi.count }
      $obj | Add-Member NoteProperty NICCount $NICCount
      $obj | Add-Member NoteProperty NICDesc $NICDesc
      $obj | Add-Member NoteProperty DHCPEnabled $NICDHCP
      $obj | Add-Member NoteProperty IPAddress $NICIP
      $obj | Add-Member NoteProperty SubnetMask $NICSubnet
      $obj | Add-Member NoteProperty Gateway $NICGateway
      $obj | Add-Member NoteProperty MACAddress $NICMAC
      $obj | Add-Member NoteProperty DNSServerSearchOrder $NICDNS
      $obj | Add-Member NoteProperty WINSPrimaryServer $NICWINS1
      $obj | Add-Member NoteProperty WINSSecondaryServer $NICWINS2
      
      write-progress -ID $ID -activity "Getting Hardware Inventory" -status "Done" -completed

      # Remove trailing ";;" characters from all properties in the object
      $properties = $obj | gm -membertype properties
      ForEach ($property in $properties) {
        $obj.($property.name) = $obj.($property.name) -replace ("$CRLF*$","")       
      }
      Write-Output $obj
    }
  }
}

################################
# Process Hardware Specs
Function Global:Docs-Hardware {
$NewRecord = "NewRecord "
$Source = "Get-Hardware.xml"
$Delim = ":"
Remove-Variable GetObj
$GetObj = @(Import-CLIXML $Source)

  $ID = 1034
  $HTMLTitle = "Server Hardware"
  $HTMLFile = "Hardware.html"
  $HTMLSubTitle = $HTMLTitle
  [int]$AppendFile = 0
  $Field = @("NewRecord","ComputerManufacturer","ComputerModel","OSName","OSVersion","SPVersion","TotalMemory")
  $Label = @("Server","Manufacturer","Model","Operating System","OS Ver","OS SP","RAM")
  $Sort = "CSName"
  $ColOrder = (7,1,2,3,5,4,6)
  $FormattedTable = Format-Object $GetObj $Field $Label $Sort
  write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 0
  Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format 

  $Field = @("NewRecord","ProcessorDeviceID","ProcessorName","ProcessorCaption","ProcessorCount","ProcessorCores","ProcessorSpeed")
  $Label = @("Server","CPU ID","CPU Name","CPU Caption","Num CPUs","Cores per CPU","CPU Speed")
  $HTMLSubTitle = $HTMLTitle+" - CPU"
  [int]$AppendFile = 1
  $Sort = "CSName"
  $ColOrder = (7,3,4,2,6,1,5)
  $FormattedTable = Format-Object $GetObj $Field $Label $Sort
  write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 10
  Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format 

  $Field = @("NewRecord","Disk","Size","DiskDescription","DriveType","MediaType")
  $Label = @("Server","Physical Disks","Disk Size","Description","Type","Media")
  $HTMLSubTitle = $HTMLTitle+" - Disk"
  $Sort = "CSName"
  $ColOrder = (5,4,2,1,6,3)
  $FormattedTable = Format-Object $GetObj $Field $Label $Sort
  write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 20
  Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format 

  $Field = @("NewRecord","LogicalDrives","VolumeName","LogicalDriveSize","DriveFreeSpace")
  $Label = @("Server","Logical Drives","Volume Name","Size","Free Space")
  $HTMLSubTitle = $HTMLTitle+" - Volume"
  $Sort = "CSName"
  $ColOrder = (3,2,5,4,1)
  $FormattedTable = Format-Object $GetObj $Field $Label $Sort
  write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 30
  Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format 

  $Field = @("NewRecord","NICCount","NICDesc","DHCPEnabled","IPAddress","SubnetMask","Gateway","MACAddress","DNSServerSearchOrder","WINSPrimaryServer","WINSSecondaryServer")
  $Label = @("Server","Num NICs","NIC","DHCP","IP Address","Subnet","Gateway","MAC Address","DNS","Primary WINS","Secondary WINS")
  $HTMLSubTitle = $HTMLTitle+" - NIC"
  $Sort = "CSName"
  $ColOrder = (10,7,6,1,4,11,3,5,2,8,9)
  $FormattedTable = Format-Object $GetObj $Field $Label $Sort
  write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 40
  Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format 

  $Field = @("NewRecord","BIOS","BIOSVersion","BIOSSerial")
  $Label = @("Server","BIOS","BIOS Version","BIOS Serial")
  $HTMLSubTitle = $HTMLTitle+" - BIOS"
  $Sort = "CSName"
  $ColOrder = (4,1,3,2)
  $FormattedTable = Format-Object $GetObj $Field $Label $Sort
  write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -percentcomplete 50
  Create-File -title $HTMLTitle -Subtitle $HTMLSubTitle -append $AppendFile -table $FormattedTable -outfile $HTMLFile -colorder $ColOrder -filetype $format 

  write-progress -ID $ID -activity $HTMLTitle -status $HTMLSubTitle -completed

}
