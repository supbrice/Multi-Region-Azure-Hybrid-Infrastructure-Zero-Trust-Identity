module "stack" {
  source = "../.."

  subscription_id                  = var.subscription_id
  environment                      = "dev"
  name_prefix                      = "hybzt"
  primary_location                 = "eastus2"
  secondary_location               = "centralus"
  primary_address_space            = ["10.10.0.0/16"]
  secondary_address_space          = ["10.20.0.0/16"]
  on_premises_address_spaces       = ["10.50.0.0/16"]
  on_premises_gateway_address      = "203.0.113.10"
  on_premises_dns_ip               = "10.50.0.10"
  enable_bastion                   = true
  bastion_sku                      = "Basic"
  vpn_sku                          = "VpnGw1"
  vpn_generation                   = "Generation1"
  vpn_shared_key                   = var.vpn_shared_key
  vm_size                          = "Standard_B1s"
  admin_ssh_public_key             = var.admin_ssh_public_key
  availability_zone                = ""
  log_retention_days               = 30
  alert_email                      = var.alert_email
  operations_group_object_id       = var.operations_group_object_id
  security_readers_group_object_id = var.security_readers_group_object_id
  create_entra_groups              = false

  primary_subnets = {
    gateway = "10.10.0.0/27"
    bastion = "10.10.1.0/26"
    mgmt    = "10.10.10.0/24"
    app     = "10.10.20.0/24"
    data    = "10.10.30.0/24"
  }

  secondary_subnets = {
    gateway = "10.20.0.0/27"
    mgmt    = "10.20.10.0/24"
    app     = "10.20.20.0/24"
    data    = "10.20.30.0/24"
  }
}
