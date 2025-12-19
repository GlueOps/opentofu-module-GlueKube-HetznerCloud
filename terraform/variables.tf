# Declare the hcloud_token variable from .tfvars
variable "hcloud_token" {
  sensitive = true # Requires terraform >= 0.14
}

variable "region" {
  type    = string
  default = "hel1"
  
}


variable "gluekube_docker_image" {
  type    = string
  default = "ghcr.io/glueops/gluekube"
}

variable "gluekube_docker_tag" {
  type    = string
  default = "v0.0.12"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "subnet_cidr" {
  type    = string
}

variable "autoglue" {
  description = "Configuration for the AutoGlue platform integration, including cluster naming, credentials, and Route53 DNS settings."
  type = object({
    autoglue_cluster_name = string
    
    credentials = object({
      autoglue_org_id     = string
      autoglue_key        = string
      autoglue_org_secret = string
      base_url            = string
    })

    route_53_config = object({
      aws_access_key_id     = string
      aws_secret_access_key = string
      aws_region            = string
      domain_name           = string
      zone_id             = string
    })
  })
}



variable "node_pools" {
  type = list(object({
    name                = string
    node_count          = number
    instance_type       = string
    role                = string
    disk_size_gb        = number
    kubernetes_labels   = map(string)
    kubernetes_taints = list(object({
      key    = string
      value  = string
      effect = string
    }))

  }))
 

  validation {
    condition     = length([for np in var.node_pools : np if np.role == "master"]) > 0
    error_message = "At least one node pool must have role = 'master'."
  }

  validation {
    condition     = sum([for np in var.node_pools : np.node_count if np.role == "master"]) % 2 == 1
    error_message = "The sum of node_count for all master node pools must be odd for proper etcd quorum."
  }
}


variable "peering_configs" {
  type = list(object({
    vpc_peering_connection_id = string
    destination_cidr_block   = string
  }))
  default = []
  description = <<-DESC
  VPC Peering configurations:
    - vpc_peering_connection_id (string): The ID of the VPC peering connection.
    - destination_cidr_block (string): The CIDR block of the destination VPC.
  DESC
}