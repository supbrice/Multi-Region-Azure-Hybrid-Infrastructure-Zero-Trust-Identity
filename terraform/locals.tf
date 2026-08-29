locals {
  location_short = {
    eastus2     = "eus2"
    eastus      = "eus"
    centralus   = "cus"
    westus2     = "wus2"
    westus3     = "wus3"
    northeurope = "neu"
    westeurope  = "weu"
  }

  primary_short   = lookup(local.location_short, var.primary_location, substr(var.primary_location, 0, 6))
  secondary_short = lookup(local.location_short, var.secondary_location, substr(var.secondary_location, 0, 6))

  tags = merge(
    {
      project     = "azure-hybrid-zero-trust"
      environment = var.environment
      managed_by  = "terraform"
      owner       = "Ngu Brice Che"
      purpose     = "portfolio-lab"
    },
    var.tags
  )
}
