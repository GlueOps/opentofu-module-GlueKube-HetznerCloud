resource "autoglue_ssh_key" "bastion" {
  name = "gluekube-bastion"
  comment = "GlueKube bastion SSH Key"
}

resource "hcloud_server" "bastion" {
  name        = "bastion"
  image       = "ubuntu-24.04"
  server_type = "cpx21"
  location    = var.region
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  network {
    network_id = hcloud_network.private_network.id
  }
  user_data = base64encode("${templatefile("${path.module}/cloudinit/cloud-init-bastion.yaml",{
    public_key = autoglue_ssh_key.bastion.public_key
    hostname = "bastion"
  })}")

  # If we don't specify this, Terraform will create the resources in parallel
  # We want this node to be created after the private network is created
  # depends_on = [hcloud_network_subnet.private_network_subnet]
}

resource "autoglue_server" "bastion" {
  hostname = "bastion"
  public_ip_address = hcloud_server.bastion.ipv4_address
  private_ip_address = tolist(hcloud_server.bastion.network)[0].ip
  role = "bastion"
  ssh_key_id = autoglue_ssh_key.bastion.id
  ssh_user = "cluster"
}


resource "autoglue_cluster_bastion" "bastion" {
    cluster_id = autoglue_cluster.cluster.id
    server_id = autoglue_server.bastion.id
}