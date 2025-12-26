resource "autoglue_ssh_key" "bastion" {
  name = "gluekube-bastion"
  comment = "GlueKube bastion SSH Key"
}

resource "hcloud_server" "bastion" {
  name        = "bastion"
  image       = var.bastion.image
  server_type = var.bastion.instance_type
  location    = var.region
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  user_data = base64encode("${templatefile("${path.module}/cloudinit/cloud-init-bastion.yaml",{
    public_key = autoglue_ssh_key.bastion.public_key
    hostname = "bastion"
  })}")

  depends_on = [hcloud_network_subnet.private_network_subnet]
  firewall_ids = [hcloud_firewall.bastion-firewall.id]
}



resource "hcloud_server_network" "bastion_network" {
  server_id = hcloud_server.bastion.id
  subnet_id = hcloud_network_subnet.private_network_subnet.id
}


resource "autoglue_server" "bastion" {
  hostname = "bastion"
  public_ip_address = hcloud_server.bastion.ipv4_address
  private_ip_address = hcloud_server_network.bastion_network.ip
  role = "bastion"
  ssh_key_id = autoglue_ssh_key.bastion.id
  ssh_user = "cluster"
}

resource "autoglue_cluster_bastion" "bastion" {
    cluster_id = autoglue_cluster.cluster.id
    server_id = autoglue_server.bastion.id
}


resource "hcloud_firewall" "bastion-firewall" {
  name = "bastion-firewall"
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