resource "azurerm_virtual_network" "main" {
    name                    = "${local.resource_prefix}-vnet"
    resource_group_name     = azurerm_resource_group.main.name
    location                = azurerm_resource_group.main.location

    address_space           = [var.vnet_address_space]

    tags = local.tags
}

resource "azurerm_subnet" "sn01" {
    name                    = "sn01"
    resource_group_name     = azurerm_resource_group.main.name
    virtual_network_name    = azurerm_virtual_network.main.name

    address_prefixes        = [var.sn01_address_space]
}

resource "azurerm_network_security_group" "main" {
    name                    = "${local.resource_prefix}-nsg"
    resource_group_name     = azurerm_resource_group.main.name
    location                = azurerm_resource_group.main.location

    tags = local.tags
}

resource "azurerm_network_security_rule" "ssh" {
    name                        = "inbound_ssh"
    priority                    = 250
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = 22
    source_address_prefix       = var.allowed_address_ssh
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.main.name
    network_security_group_name = azurerm_network_security_group.main.name
}

resource "azurerm_subnet_network_security_group_association" "sn01" {
    subnet_id                   = azurerm_subnet.sn01.id
    network_security_group_id   = azurerm_network_security_group.main.id
}