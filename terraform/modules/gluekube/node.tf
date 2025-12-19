
resource "random_string" "random" {
  length           = 10
  special          = true
  override_special = "/@£$"
}

resource "hcloud_server" "cluster_node" {
  for_each    = toset([for i in range(0, var.node_count) : tostring(i)])
  name        = "${var.node_pool_name}-${each.key}"
  image       = "ubuntu-24.04"
  server_type = var.instance_type
  location    = var.region
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  user_data = base64encode("${templatefile("${path.module}/cloudinit/cloud-init-${var.role}.yaml",{
    public_key = autoglue_ssh_key.ssh-key.public_key
    hostname = "${var.role}-node-${each.key}"
  })}")

  firewall_ids = [hcloud_firewall.myfirewall.id]
}

resource "hcloud_server_network" "cluster_node_network" {
  for_each = hcloud_server.cluster_node
  server_id = each.value.id
  network_id = var.network_id
  subnet_id = var.subnet_id
}



resource "hcloud_firewall" "myfirewall" {
  name = random_string.random.result

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "any"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "udp"
    port      = "any"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

}



