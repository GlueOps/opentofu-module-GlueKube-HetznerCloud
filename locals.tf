locals {
  # Hetzner attaches the private network as a second NIC (enp7s0) that Ubuntu's default netplan
  # leaves unconfigured; bring it up with DHCP so the server gets its private IP.
  private_network_netplan = {
    path        = "/etc/netplan/60-private-network.yaml"
    content     = yamlencode({ network = { version = 2, ethernets = { enp7s0 = { dhcp4 = true } } } })
    permissions = "0600"
  }
}
