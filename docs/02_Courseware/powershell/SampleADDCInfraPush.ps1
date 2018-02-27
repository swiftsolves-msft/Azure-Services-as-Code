$time = get-date

Write-Host $time

# Variables for common values, Please be sure to change these for your enviroment.
$rgName='rgCustomAAA' #New rg being created for addc vms and other resources needed
$location='eastus'
$addc001name = "vmaddceus001"
$addc002name = "vmaddceus002"
$vmSize = "Standard_DS2"
$privateIp1 = "192.168.1.4"
$privateIp2 = "192.168.1.5"
$vnetname = "VNET-EUS-01"

# Create user object for local username and password so new VMs created will have a local user / pass, interactive prompt
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."



# Authenticate in Azure RM
Login-AzureRmAccount

# Select your subscription to deploy in, interactive prompt
$SubId = Get-AzureRmSubscription | Out-GridView -PassThru

Set-AzureRmContext -SubscriptionId $SubId.SubscriptionId

$subnetConfig = New-AzureRmVirtualNetworkSubnetConfig `
    -Name mySubnet `
    -AddressPrefix 192.168.1.0/24


$vnet = New-AzureRmVirtualNetwork `
  -ResourceGroupName $rgName `
  -Location $location `
  -Name $vnetname `
  -AddressPrefix 192.168.0.0/16 `
  -Subnet $subnetConfig

#obtain object of the existing VNET to deploy VMs into, we will reference this object variable later in script.
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $vnetrgname -Name $vnetname

# Create a resource group for the ADDC deployemnt.
New-AzureRmResourceGroup -Name $rgName -Location $location

# Create a public IP address to RDP into AD DC.
$publicIp1 = New-AzureRmPublicIpAddress -ResourceGroupName $rgName -Name $addc001name"-pip" `
  -Location $location -AllocationMethod Dynamic

  # Create a public IP address to RDP into AD DC.
$publicIp2 = New-AzureRmPublicIpAddress -ResourceGroupName $rgName -Name $addc002name"-pip" `
  -Location $location -AllocationMethod Dynamic

  # Create a network security group rule for port 3389.
$rule1 = New-AzureRmNetworkSecurityRuleConfig -Name 'RDP-Allow' -Description 'Allow RDP' `
  -Access Allow -Protocol Tcp -Direction Inbound -Priority 1000 `
  -SourceAddressPrefix Internet -SourcePortRange * `
  -DestinationAddressPrefix * -DestinationPortRange 3389

  # Create a network security group
$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $RgName -Location $location `
-Name "vm-nsg" -SecurityRules $rule1


# Create virtual network cards and associate with public IP address and NSG and also static internal ip.
$nicVM1 = New-AzureRmNetworkInterface -ResourceGroupName $rgName -Location $location `
  -Name $addc001name"-nic" -NetworkSecurityGroup $nsg `
  -Subnet $vnet.Subnets[0] -PublicIpAddress $publicIp1 -PrivateIpAddress $privateIp1 #be sure to change [#] to correspond to proper subnet

$nicVM2 = New-AzureRmNetworkInterface -ResourceGroupName $rgName -Location $location `
  -Name $addc002name"-nic" -NetworkSecurityGroup $nsg `
  -Subnet $vnet.Subnets[0] -PublicIpAddress $publicIp2 -PrivateIpAddress $privateIp2 #be sure to change [#] to correspond to proper subnet

  # Create an availability set.
$as = New-AzureRmAvailabilitySet -ResourceGroupName $rgName -Location $location `
  -Name 'ADDC-AVSet' -Sku Aligned -PlatformFaultDomainCount 2 -PlatformUpdateDomainCount 5

  # ############## VM1 ###############

# Create a virtual machine configuration
$vmConfig = New-AzureRmVMConfig -VMName $addc001name -VMSize $vmSize -AvailabilitySetId $as.Id | `
  Set-AzureRmVMOperatingSystem -Windows -ComputerName $addc001name -Credential $cred | `
  Set-AzureRmVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer `
  -Skus 2016-Datacenter -Version latest | Add-AzureRmVMNetworkInterface -Id $nicVM1.Id

# Create a virtual machine
$vm1 = New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vmConfig

# ############## VM2 ###############

# Create a virtual machine configuration
$vmConfig = New-AzureRmVMConfig -VMName $addc002name -VMSize $vmSize -AvailabilitySetId $as.Id | `
  Set-AzureRmVMOperatingSystem -Windows -ComputerName $addc002name -Credential $cred | `
  Set-AzureRmVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer `
  -Skus 2016-Datacenter -Version latest | Add-AzureRmVMNetworkInterface -Id $nicVM2.Id

# Create a virtual machine
$vm2 = New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vmConfig


# Add Data Disks to both ad dc VMs for deployment of SYSVOL and ad db

$storageType = 'PremiumLRS'
$dataDiskName = $addc001name + '_datadisk1'

$diskConfig = New-AzureRmDiskConfig -AccountType $storageType -Location $location -CreateOption Empty -DiskSizeGB 128
$dataDisk1 = New-AzureRmDisk -DiskName $dataDiskName -Disk $diskConfig -ResourceGroupName $rgName

$vm = Get-AzureRmVM -Name $addc001name -ResourceGroupName $rgName 
$vm = Add-AzureRmVMDataDisk -VM $vm -Name $dataDiskName -CreateOption Attach -ManagedDiskId $dataDisk1.Id -Lun 1

Update-AzureRmVM -VM $vm -ResourceGroupName $rgName

$storageType = 'PremiumLRS'
$dataDiskName = $addc002name + '_datadisk1'

$diskConfig = New-AzureRmDiskConfig -AccountType $storageType -Location $location -CreateOption Empty -DiskSizeGB 128
$dataDisk1 = New-AzureRmDisk -DiskName $dataDiskName -Disk $diskConfig -ResourceGroupName $rgName

$vm = Get-AzureRmVM -Name $addc002name -ResourceGroupName $rgName 
$vm = Add-AzureRmVMDataDisk -VM $vm -Name $dataDiskName -CreateOption Attach -ManagedDiskId $dataDisk1.Id -Lun 1

Update-AzureRmVM -VM $vm -ResourceGroupName $rgName

$time = get-date

Write-Host $time
