# Declare the hcloud_token variable from .tfvars
variable "hcloud_token" {
  sensitive = true # Requires terraform >= 0.14
}
variable "master_node_count" {
  type = number
  default = 3
}

variable "worker_node_count" {
  type = number
  default = 6
}

variable "location" {
  type = string
  default = "hel1"
  
}

variable "autoglue_org_id" {
  type = string
}

variable "autoglue_key" {
  type = string
  sensitive = true
}

variable "autoglue_org_secret" {
  type = string
  sensitive = true
}
variable "autoglue_cluster_name" {
  type = string
  default = "demo"
}

variable "zone_id" {
  type = string
  sensitive = true
}

variable "aws_access_key_id_route53" {
  type = string
  sensitive = true
}

variable "aws_secret_access_key_route53" {
  type = string
  sensitive = true
}
variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-west-2"
}

variable "domain_name" {
  type = string
  sensitive = true
}

variable "server_type" {
  type = string
  default = "cpx21"
}


variable "gluekube_docker_image" {
  type = string
  default = "ghcr.io/glueops/gluekube"
}

variable "gluekube_docker_tag" {
  type = string
  default = "v0.0.9"
}