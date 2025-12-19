# Tell Terraform to include the hcloud provider
terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.49.1"
    }
    autoglue = {
      source = "registry.terraform.io/GlueOps/autoglue"
      version = "0.9.2"
    }
  }
}

# Configure the Hetzner Cloud Provider with your token
provider "hcloud" {
  token = var.hcloud_token
}


provider "autoglue" {
  org_id = var.autoglue.credentials.autoglue_org_id
  base_url = var.autoglue.credentials.base_url
  org_key = var.autoglue.credentials.autoglue_key
  org_secret = var.autoglue.credentials.autoglue_org_secret
}

provider "aws" {
  alias = "aws_route53"
  region  = var.autoglue.route_53_config.aws_region
  access_key = var.autoglue.route_53_config.aws_access_key_id
  secret_key = var.autoglue.route_53_config.aws_secret_access_key
}
