resource "azurerm_public_ip" "vm" {
  name                = "${local.resource_prefix}-vm-ip"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  allocation_method = "Dynamic"
  domain_name_label = "${local.resource_prefix}-vm-ip"

  tags = local.tags
}

resource "azurerm_network_interface" "vm" {
  name                = "${local.resource_prefix}-vm-nic"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "nic"
    subnet_id                     = azurerm_subnet.sn01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm.id
  }

  tags = local.tags
}

data "template_cloudinit_config" "vm" {
  part {
    filename     = "base.yaml"
    content_type = "text/cloud-config"
    content      = file("${path.module}/cloud-init/base.yaml")
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${local.resource_prefix}-vm"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  size = var.vm.size

  admin_username = random_pet.main.id
  admin_ssh_key {
    username   = random_pet.main.id
    public_key = tls_private_key.ssh_key.public_key_openssh
  }
  disable_password_authentication = true
  encryption_at_host_enabled      = true
  custom_data                     = data.template_cloudinit_config.vm.rendered

  network_interface_ids = [
    azurerm_network_interface.vm.id
  ]

  boot_diagnostics {
  }

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = var.vm.os_disk.caching
    storage_account_type = var.vm.os_disk.type
    disk_size_gb         = var.vm.os_disk.size
    name                 = "${local.resource_prefix}-vm-osdisk"
  }

  source_image_reference {
    publisher = var.vm.image.publisher
    offer     = var.vm.image.offer
    sku       = var.vm.image.sku
    version   = "latest"
  }
}

resource "azurerm_virtual_machine_extension" "ssh_login" {
    name                  = "AADSSHLoginForLinux"
    virtual_machine_id    = azurerm_linux_virtual_machine.vm.id
    publisher             = "Microsoft.Azure.ActiveDirectory"
    type                  = "AADSSHLoginForLinux"
    type_handler_version  = "1.0"
    automatic_upgrade_enabled = true
}