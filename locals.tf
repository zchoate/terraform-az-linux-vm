resource "random_string" "rand" {
    length  = "5"
    lower   = true
    upper   = false
    numeric = true
    special = false
}

locals {
    resource_prefix_partial = "${var.location_short}-${var.project_short}-${var.environment}-${random_string.rand.result}"
    resource_prefix = lower(local.resource_prefix_partial)
    resource_prefix_short_partial = substr(replace(lower("${var.location_short}${var.project_short}"), "/\\W/", ""),0, 14)
    resource_prefix_short = "${local.resource_prefix_short_partial}${random_string.rand.result}"
    tags = tomap({
        "project"   = var.project
    })
}