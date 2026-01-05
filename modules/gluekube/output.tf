output "role" {
  value = var.role
}

output "master_private_ips" {
  value = var.role == "master" ? [for s in autoglue_server.node : s.private_ip_address] : []
}
