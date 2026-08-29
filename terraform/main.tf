resource "azurerm_resource_group" "shared" {
  name     = "${var.name_prefix}-${var.environment}-shared-${local.primary_short}"
  location = var.primary_location
  tags     = local.tags
}

resource "azurerm_resource_group" "compute" {
  name     = "${var.name_prefix}-${var.environment}-compute-${local.primary_short}"
  location = var.primary_location
  tags     = local.tags
}

module "networking_primary" {
  source = "./modules/networking"

  name                       = "${var.name_prefix}-${var.environment}-${local.primary_short}"
  location                   = var.primary_location
  resource_group_name        = "${var.name_prefix}-${var.environment}-net-${local.primary_short}"
  address_space              = var.primary_address_space
  subnets                    = var.primary_subnets
  on_premises_address_spaces = var.on_premises_address_spaces
  enable_bastion             = var.enable_bastion
  bastion_sku                = var.bastion_sku
  enable_nat_gateway         = true
  tags                       = local.tags
}

module "networking_secondary" {
  source = "./modules/networking"

  name                       = "${var.name_prefix}-${var.environment}-${local.secondary_short}"
  location                   = var.secondary_location
  resource_group_name        = "${var.name_prefix}-${var.environment}-net-${local.secondary_short}"
  address_space              = var.secondary_address_space
  subnets                    = var.secondary_subnets
  on_premises_address_spaces = var.on_premises_address_spaces
  enable_bastion             = false
  enable_nat_gateway         = true
  tags                       = local.tags
}

resource "azurerm_virtual_network_peering" "primary_to_secondary" {
  name                      = "peer-${local.primary_short}-to-${local.secondary_short}"
  resource_group_name       = module.networking_primary.resource_group_name
  virtual_network_name      = module.networking_primary.vnet_name
  remote_virtual_network_id = module.networking_secondary.vnet_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
  use_remote_gateways       = false
}

resource "azurerm_virtual_network_peering" "secondary_to_primary" {
  name                      = "peer-${local.secondary_short}-to-${local.primary_short}"
  resource_group_name       = module.networking_secondary.resource_group_name
  virtual_network_name      = module.networking_secondary.vnet_name
  remote_virtual_network_id = module.networking_primary.vnet_id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = true

  depends_on = [module.hybrid_vpn]
}

module "hybrid_vpn" {
  source = "./modules/hybrid-vpn"

  name                        = "${var.name_prefix}-${var.environment}-${local.primary_short}"
  location                    = var.primary_location
  resource_group_name         = module.networking_primary.resource_group_name
  gateway_subnet_id           = module.networking_primary.gateway_subnet_id
  sku                         = var.vpn_sku
  generation                  = var.vpn_generation
  on_premises_gateway_name    = "${var.name_prefix}-${var.environment}-onprem-lng"
  on_premises_gateway_address = var.on_premises_gateway_address
  on_premises_address_spaces  = var.on_premises_address_spaces
  shared_key                  = var.vpn_shared_key
  tags                        = local.tags
}

resource "azurerm_private_dns_zone" "internal" {
  name                = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.shared.name
  tags                = local.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "primary" {
  name                  = "link-${local.primary_short}"
  resource_group_name   = azurerm_resource_group.shared.name
  private_dns_zone_name = azurerm_private_dns_zone.internal.name
  virtual_network_id    = module.networking_primary.vnet_id
  registration_enabled  = true
}

resource "azurerm_private_dns_zone_virtual_network_link" "secondary" {
  name                  = "link-${local.secondary_short}"
  resource_group_name   = azurerm_resource_group.shared.name
  private_dns_zone_name = azurerm_private_dns_zone.internal.name
  virtual_network_id    = module.networking_secondary.vnet_id
  registration_enabled  = true
}

resource "azurerm_private_dns_a_record" "onprem_resolver" {
  name                = "onprem-dns"
  zone_name           = azurerm_private_dns_zone.internal.name
  resource_group_name = azurerm_resource_group.shared.name
  ttl                 = 300
  records             = [var.on_premises_dns_ip]
}

module "identity" {
  source = "./modules/identity"

  name_prefix         = "${var.name_prefix}-${var.environment}"
  environment         = var.environment
  location            = var.primary_location
  resource_group_name = azurerm_resource_group.shared.name
  assignable_scopes = [
    azurerm_resource_group.shared.id,
    azurerm_resource_group.compute.id,
    module.networking_primary.resource_group_id,
    module.networking_secondary.resource_group_id,
  ]
  operations_group_object_id       = var.operations_group_object_id
  security_readers_group_object_id = var.security_readers_group_object_id
  create_entra_groups              = var.create_entra_groups
  tags                             = local.tags
}

module "monitoring" {
  source = "./modules/monitoring"

  name_prefix                    = "${var.name_prefix}${var.environment}"
  location                       = var.primary_location
  resource_group_name            = azurerm_resource_group.shared.name
  log_retention_days             = var.log_retention_days
  alert_email                    = var.alert_email
  vpn_gateway_id                 = module.hybrid_vpn.gateway_id
  workload_identity_principal_id = module.identity.workload_identity_principal_id
  tags                           = local.tags

  diagnostic_targets = {
    nsg-primary-mgmt   = module.networking_primary.nsg_ids.mgmt
    nsg-primary-app    = module.networking_primary.nsg_ids.app
    nsg-primary-data   = module.networking_primary.nsg_ids.data
    nsg-secondary-mgmt = module.networking_secondary.nsg_ids.mgmt
    vpn-gateway        = module.hybrid_vpn.gateway_id
  }
}

module "compute" {
  source = "./modules/compute"

  name                      = "${var.name_prefix}-${var.environment}-mgmt"
  location                  = var.primary_location
  resource_group_name       = azurerm_resource_group.compute.name
  subnet_id                 = module.networking_primary.mgmt_subnet_id
  vm_size                   = var.vm_size
  admin_username            = var.admin_username
  admin_ssh_public_key      = var.admin_ssh_public_key
  user_assigned_identity_id = module.identity.workload_identity_id
  data_collection_rule_id   = module.monitoring.data_collection_rule_id
  availability_zone         = var.availability_zone
  tags                      = local.tags
}
