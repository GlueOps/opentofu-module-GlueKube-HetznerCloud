# The cloud-config shared with the AWS and Proxmox modules. Only what is specific to this platform
# is passed in; the update policy, the post-upgrade reboot and the `cluster` user live there.
module "cloud_init" {
  source   = "git::https://github.com/GlueOps/opentofu-module-GlueKube-cloudinit.git?ref=v0.2.0"
  for_each = toset([for i in range(0, var.node_count) : tostring(i)])

  hostname   = "${var.role}-${var.name}-${each.key}"
  public_key = autoglue_ssh_key.ssh_key.public_key

  extra_write_files = [
    {
      # Read by GlueKube's apply-calico-firewall.yaml. eth0 carries the public IP on Hetzner Cloud.
      path        = "/etc/glueops/public-interface"
      content     = "eth0\n"
      permissions = "0644"
    },
    local.private_network_netplan,
  ]
  extra_runcmd = ["netplan apply"]
}

resource "hcloud_server" "cluster_node" {
  for_each    = toset([for i in range(0, var.node_count) : tostring(i)])
  name        = "${var.role}-${var.name}-${each.key}"
  image       = var.image
  server_type = var.instance_type
  location    = var.region
  public_net {
    ipv4_enabled = true
    ipv6_enabled = var.enable_ipv6
  }
  user_data = base64encode(module.cloud_init[each.key].user_data)

  firewall_ids = [hcloud_firewall.firewall.id]

  lifecycle {
    ignore_changes = [user_data, public_net]
  }
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
  rule {
    direction = "in"
    protocol  = "icmp"
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



