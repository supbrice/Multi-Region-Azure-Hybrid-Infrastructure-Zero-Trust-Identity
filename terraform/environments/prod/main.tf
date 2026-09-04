module "stack" {
  source = "../.."

  subscription_id                  = var.subscription_id
  environment                      = "prod"
  name_prefix                      = "hybzt"
  primary_location                 = "eastus2"
  secondary_location               = "centralus"
  primary_address_space            = ["10.100.0.0/16"]
  secondary_address_space          = ["10.200.0.0/16"]
  on_premises_address_spaces       = ["10.0.0.0/16"]
  on_premises_gateway_address      = "203.0.113.20"
  on_premises_dns_ip               = "10.0.0.10"
  enable_bastion                   = true
  bastion_sku                      = "Standard"
  vpn_sku                          = "VpnGw2"
  vpn_generation                   = "Generation2"
  vpn_shared_key                   = var.vpn_shared_key
  vm_size                          = "Standard_B2s"
  admin_ssh_public_key             = var.admin_ssh_public_key
  availability_zone                = "1"
  log_retention_days               = 90
  alert_email                      = var.alert_email
  operations_group_object_id       = var.operations_group_object_id
  security_readers_group_object_id = var.security_readers_group_object_id
  create_entra_groups              = false

  primary_subnets = {
    gateway = "10.100.0.0/27"
    bastion = "10.100.1.0/26"
    mgmt    = "10.100.10.0/24"
    app     = "10.100.20.0/24"
    data    = "10.100.30.0/24"
  }

  secondary_subnets = {
    gateway = "10.200.0.0/27"
    mgmt    = "10.200.10.0/24"
    app     = "10.200.20.0/24"
    data    = "10.200.30.0/24"
  }
}
