variable "vnet_address_space" {
    description = "Address space for virtual network"
    default     = "10.50.0.0/16"
    type        = string
}

variable "sn01_address_space" {
    description = "Address space for subnet 1"
    default     = "10.50.1.0/24"
    type        = string
}

variable "allowed_address_ssh" {
    description = "Address prefix for inbound SSH"
    type        = string
}

variable "vm" {
    description = "Values for Linux virtual machine resource"
    default     = {
        size = "Standard_B2ms"
        os_disk = {
            caching     = "ReadOnly"
            type        = "StandardSSD_LRS"
            size        = 128
        }
        image = {
            publisher   = "Canonical"
            offer       = "0001-com-ubuntu-server-jammy"
            sku         = "22_04-lts-gen2"
        }
    }
}