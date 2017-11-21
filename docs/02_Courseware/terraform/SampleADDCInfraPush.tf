provider "azurerm" {
  subscription_id = "${var.azu_subid}"
  client_id       = "${var.azu_clientid}"
  client_secret   = "${var.azu_clientkey}"
  tenant_id       = "${var.azu_tenantid}"
}

# Create a resource group
resource "azurerm_resource_group" "rgCustomAAA2" {
  name     = "rgCustomAAA2"
  location = "${var.azu_location}"
        tags {
        "costCenter" = "1101"
	    "enviroment" = "Production"
        "owner" = "someone@customedomain.com"
    }
}

# Diagnostic Storage Account
resource "azurerm_storage_account" "rpathaddcazudiag" {
  name                = "rpathaddcazudiag"
  resource_group_name = "${azurerm_resource_group.rgCustomAAA2.name}"
  location = "${var.azu_location}"
  account_type = "Standard_LRS"
}

resource "azurerm_availability_set" "addc-avset" {
  name                = "ADDC-AVSet"
  location            = "${var.azu_location}"
  resource_group_name = "${azurerm_resource_group.rgCustomAAA2.name}"
    managed           = "true"

  tags {
    description = "AVSet for local forest AD domain controlers to implment authentication tolerance, no load balancers needed"
  }
}

# Network Security Group
resource "azurerm_network_security_group" "vm-nsg2" {
    name        = "vm-nsg2"
    location = "${var.azu_location}"
    resource_group_name = "${azurerm_resource_group.rgCustomAAA2.name}"

    security_rule {
    name                       = "RDP-Allow"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

}

# Subnet ConfigurationBlock - use for terraform import "azurerm_subnet.existSubnet" "/subscriptions/YOURSUBID/resourceGroups/YOURRG/providers/Microsoft.Network/virtualNetworks/VNETNAME/subnets/SUBNETNAME"

#resource "azurerm_subnet" "existSubnet" {}

resource "azurerm_subnet" "existSubnet" {
  name                 = "AAA"
  resource_group_name  = "rgSwiftNetworking"
  virtual_network_name = "VNET-EUS2-01"
  address_prefix       = "192.168.1.0/24"
}

# Network Interface
resource "azurerm_network_interface" "vm1-nic1" {
  name                = "${var.hostname1}-nic1"
  location            = "${var.azu_location}"
  resource_group_name = "${azurerm_resource_group.rgCustomAAA2.name}"
  network_security_group_id = "${azurerm_network_security_group.vm-nsg2.id}"

  ip_configuration {
    name                          = "addcconfig1"
    subnet_id                     = "${azurerm_subnet.existSubnet.id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "192.268.1.200"   
    public_ip_address_id          = "${azurerm_public_ip.vm1-pip.id}"
  }
}

# Public IP address
resource "azurerm_public_ip" "vm1-pip" {
  name                         = "${var.hostname1}-pip"
  location                     = "${var.azu_location}"
  resource_group_name          = "${azurerm_resource_group.rgCustomAAA2.name}"
  public_ip_address_allocation = "dynamic"
}


# Virtual Machine
resource "azurerm_virtual_machine" "vm1" {
  name                  = "${var.hostname1}"
  location              = "${var.azu_location}"
  resource_group_name   = "${azurerm_resource_group.rgCustomAAA2.name}"
  vm_size               = "Standard_DS2"
  network_interface_ids = ["${azurerm_network_interface.vm1-nic1.id}"]
  availability_set_id  = "${azurerm_availability_set.addc-avset.id}"


  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.hostname1}-osdisk"
    managed_disk_type = "Premium_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  storage_data_disk {
    name              = "${var.hostname1}-datadisk"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = "128"
    create_option     = "Empty"
    lun               = 1
  }

  os_profile {
    computer_name  = "${var.hostname1}"
    admin_username = "eagle"
    admin_password = "Crawford687!!"
  }


  boot_diagnostics {
    enabled     = true
    storage_uri = "${azurerm_storage_account.rpathaddcazudiag.primary_blob_endpoint}"
  }
}

# Network Interface
resource "azurerm_network_interface" "vm2-nic1" {
  name                = "${var.hostname2}-nic1"
  location            = "${var.azu_location}"
  resource_group_name = "${azurerm_resource_group.rgCustomAAA2.name}"
  network_security_group_id = "${azurerm_network_security_group.vm-nsg2.id}"

  ip_configuration {
    name                          = "addcconfig1"
    #subnet_id                     = "${azurerm_subnet.existSubnet.id}"
    subnet_id                     = "${var.existing_subnet_id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "192.168.1.201"   
    public_ip_address_id          = "${azurerm_public_ip.vm2-pip.id}"
  }
}

# Public IP address
resource "azurerm_public_ip" "vm2-pip" {
  name                         = "${var.hostname2}-pip"
  location                     = "${var.azu_location}"
  resource_group_name          = "${azurerm_resource_group.rgCustomAAA2.name}"
  public_ip_address_allocation = "dynamic"
}


# Virtual Machine
resource "azurerm_virtual_machine" "vm2" {
  name                  = "${var.hostname2}"
  location              = "${var.azu_location}"
  resource_group_name   = "${azurerm_resource_group.rgCustomAAA2.name}"
  vm_size               = "Standard_DS2"
  network_interface_ids = ["${azurerm_network_interface.vm2-nic1.id}"]
  availability_set_id  = "${azurerm_availability_set.addc-avset.id}"


  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.hostname2}-osdisk"
    managed_disk_type = "Premium_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  storage_data_disk {
    name              = "${var.hostname2}-datadisk"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = "128"
    create_option     = "Empty"
    lun               = 1
  }

  os_profile {
    computer_name  = "${var.hostname2}"
    admin_username = "eagle"
    admin_password = "Crawford687!!"
  }


  boot_diagnostics {
    enabled     = true
    storage_uri = "${azurerm_storage_account.rpathaddcazudiag.primary_blob_endpoint}"
  }
}