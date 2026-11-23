resource "autoglue_ssh_key" "bastion" {
  name    = "${var.autoglue.autoglue_cluster_name}-bastion"
  comment = "GlueKube bastion SSH Key"
}

module "bastion_cloud_init" {
  source = "git::https://github.com/GlueOps/opentofu-module-GlueKube-cloudinit.git?ref=v0.2.0"

  hostname   = "bastion"
  public_key = autoglue_ssh_key.bastion.public_key

  extra_write_files = [local.private_network_netplan]
  extra_runcmd      = ["netplan apply"]
}

resource "hcloud_server" "bastion" {
  name        = "${var.autoglue.autoglue_cluster_name}-bastion"
  image       = var.bastion.image
  server_type = var.bastion.instance_type
  location    = var.region
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  user_data = base64encode(module.bastion_cloud_init.user_data)

  depends_on   = [hcloud_network_subnet.private_network_subnet]
  firewall_ids = [hcloud_firewall.bastion_firewall.id]
}



resource "hcloud_server_network" "bastion_network" {
  server_id = hcloud_server.bastion.id
  subnet_id = hcloud_network_subnet.private_network_subnet.id
}


resource "autoglue_server" "bastion" {
  hostname           = "bastion"
  public_ip_address  = hcloud_server.bastion.ipv4_address
  private_ip_address = hcloud_server_network.bastion_network.ip
  role               = "bastion"
  ssh_key_id         = autoglue_ssh_key.bastion.id
  ssh_user           = "cluster"
}

resource "autoglue_cluster_bastion" "bastion" {
  cluster_id = autoglue_cluster.cluster.id
  server_id  = autoglue_server.bastion.id
}


resource "hcloud_firewall" "bastion_firewall" {
  name = "${var.autoglue.autoglue_cluster_name}-bastion-firewall"
  # Public access - SSH (port 22)
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

}