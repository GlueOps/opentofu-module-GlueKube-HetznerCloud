variable "network_id" {
  type = string
}

variable "subnet_id" {
  type        = string
  description = "The CIDR block for the subnet."

}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC/private network."
}

variable "instance_type" {
  type = string
}

variable "image" {
  type = string
}

variable "region" {
  type        = string
  description = "The Hetzner Cloud region/location for the nodes."
  default     = "hel1"
}

variable "node_count" {
  type    = number
  default = 1
}

variable "role" {
  type = string
}

variable "kubernetes_labels" {
  type = map(string)
}

variable "kubernetes_taints" {
  type = list(object({
    key    = string
    value  = string
    effect = string
  }))
  default = []
}


variable "name" {
  type = string
}

variable "cluster_name" {
  type = string
}
