variable "provider_credentials" {
  type = object({
    name   = string
    token  = string
    region = string
  })
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
  validation {
    condition     = can(cidrnetmask(var.vpc_cidr_block))
    error_message = "vpc_cidr_block must be a valid IPv4 CIDR block, for example: 10.0.1.0/24."
  }
}

variable "subnet_cidr" {
  type = string
  validation {
    condition     = can(cidrnetmask(var.subnet_cidr))
    error_message = "subnet_cidr must be a valid IPv4 CIDR block, for example: 10.0.1.0/24."
  }
}

variable "bastion" {
  description = "Bastion configuration."
  type = object({
    instance_type = string
    image         = string
  })
}

variable "autoglue" {
  description = "Configuration for the AutoGlue platform integration, including cluster naming, credentials, and Route53 DNS settings."
  type = object({
    autoglue_cluster_name = string

    credentials = object({
      autoglue_key        = string
      autoglue_org_secret = string
      base_url            = string
    })

    route_53_config = object({
      aws_access_key_id     = string
      aws_secret_access_key = string
      aws_region            = string
      domain_name           = string
      zone_id               = string
      credential_id         = string
    })
  })
}



variable "node_pools" {
  type = list(object({
    name              = string
    image             = string
    node_count        = number
    instance_type     = string
    role              = string
    kubernetes_labels = map(string)
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

  validation {
    condition     = alltrue([for np in var.node_pools : contains(["master", "worker"], np.role)])
    error_message = "Each node pool role must be either 'master' or 'worker'."
  }
}

