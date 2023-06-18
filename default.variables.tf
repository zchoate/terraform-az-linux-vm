variable "location" {
    description = "Azure Region, example: `eastus`"
    type        = string
    default     = "eastus2"
}
variable "location_short" {
    description = "Abbreviation for the region, example: `eus`"
    type        = string
    default     = "eus2"
}
variable "project" {
    description = "Project name"
    type        = string
}
variable "project_short" {
    description = "Abbreviation of project name"
    type        = string
}
variable "environment" {
    description = "Dev, UAT, Prod"
    type        = string
    default     = "dev"
}