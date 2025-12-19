
resource "autoglue_cluster" "cluster" {
  cluster_provider = "hetznercloud"
  docker_image = var.gluekube_docker_image
  docker_tag = var.gluekube_docker_tag
  name = var.autoglue.autoglue_cluster_name
  region = var.autoglue.route_53_config.aws_region
}


resource "autoglue_credential" "route53" {
  name        = "route53-main"
  account_id = "1234567890"
  credential_provider = "aws"
  kind  = "aws_access_key"

  schema_version = "1"

  
  # Whatever your provider expects for the AWS/Route53 scope:
  scope = {
    service = "route53"
  }

  scope_version = 1
  scope_kind  = "service"

  secret = {
    access_key_id = var.autoglue.route_53_config.aws_access_key_id
    secret_access_key = var.autoglue.route_53_config.aws_secret_access_key
  }

  region     = var.autoglue.route_53_config.aws_region
}

