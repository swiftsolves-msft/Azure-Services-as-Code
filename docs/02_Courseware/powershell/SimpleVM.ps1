$time = get-date

Write-Host $time

New-AzureRmVm `
    -ResourceGroupName "myResourceGroup1" `
    -Name "myVM$(Get-Random)" `
    -Location "East US" `
    -VirtualNetworkName "myVnet1" `
    -SubnetName "mySubnet1" `
    -SecurityGroupName "myNetworkSecurityGroup1" `
    -PublicIpAddressName "myPublicIpAddress1" `
    -OpenPorts 80,3389

$time = get-date

Write-Host $time