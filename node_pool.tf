module "node_pool" {
  for_each          = { for np in var.node_pools : np.name => np }
  source            = "./modules/gluekube"
  name              = each.value.name
  instance_type     = each.value.instance_type
  image             = each.value.image
  role              = each.value.role
  node_count        = each.value.node_count
  kubernetes_labels = each.value.kubernetes_labels
  kubernetes_taints = each.value.kubernetes_taints
  network_id        = hcloud_network.private_network.id
  subnet_id         = hcloud_network_subnet.private_network_subnet.id
  vpc_cidr          = var.vpc_cidr_block
  cluster_name      = var.autoglue.autoglue_cluster_name
  region            = var.region
}

resource "autoglue_cluster_node_pools" "autoglue_cluster_node_pools" {
  cluster_id = autoglue_cluster.cluster.id
  node_pool_ids = [
    for np in module.node_pool : np.node_pool_id
  ]
}
