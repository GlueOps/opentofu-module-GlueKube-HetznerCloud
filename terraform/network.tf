resource "hcloud_network" "private_network" {
  name     = var.autoglue.autoglue_cluster_name
  ip_range = var.vpc_cidr_block
}

resource "hcloud_network_subnet" "private_network_subnet" {
  type         = "cloud"
  network_id   = hcloud_network.private_network.id
  network_zone = var.region
  ip_range     = var.subnet_cidr
}

