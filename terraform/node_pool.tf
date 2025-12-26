module "node_pool" {
    for_each              = { for np in var.node_pools : np.name => np }
    source                = "./modules/gluekube"
    name                  = each.value.name
    instance_type         = each.value.instance_type
    image                 = each.value.image
    role                  = each.value.role
    node_count            = each.value.node_count
    kubernetes_labels     = each.value.kubernetes_labels
    kubernetes_taints     = each.value.kubernetes_taints
    zone_id               = var.autoglue.route_53_config.zone_id
    credential_id         = autoglue_credential.route53.id
    domain_name           = var.autoglue.route_53_config.domain_name
    network_id            = hcloud_network.private_network.id
    subnet_id             = hcloud_network_subnet.private_network_subnet.id
    vpc_cidr              = var.vpc_cidr_block
}