
resource "hcloud_server" "cluster_node" {
  for_each    = toset([for i in range(0, var.node_count) : tostring(i)])
  name        = "${var.cluster_name}-${var.name}-${each.key}"
  image       = var.image
  server_type = var.instance_type
  location    = var.region
  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }
  user_data = base64encode("${templatefile("${path.module}/cloudinit/cloud-init-${var.role}.yaml", {
    public_key = autoglue_ssh_key.ssh_key.public_key
    hostname   = "${var.cluster_name}-${var.name}-${each.key}"
  })}")

  firewall_ids = [hcloud_firewall.firewall.id]
}

resource "hcloud_server_network" "cluster_node_network" {
  for_each  = hcloud_server.cluster_node
  server_id = each.value.id
  subnet_id = var.subnet_id
}



resource "hcloud_firewall" "firewall" {
  name = "${var.cluster_name}-${var.name}-firewall"

  # Internal/private network - allow all TCP ports
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "any"
    source_ips = [
      var.vpc_cidr
    ]
  }

  # Internal/private network - allow all UDP ports
  rule {
    direction = "in"
    protocol  = "udp"
    port      = "any"
    source_ips = [
      var.vpc_cidr
    ]
  }

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

  # Public access - HTTP (port 80)
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  # Public access - HTTPS (port 443)
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}



