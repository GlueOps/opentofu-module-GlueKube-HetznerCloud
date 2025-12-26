
resource "autoglue_cluster" "cluster" {
  cluster_provider = var.provider_credentials.name
  docker_image = var.gluekube_docker_image
  docker_tag = var.gluekube_docker_tag
  name = var.autoglue.autoglue_cluster_name
  region = var.autoglue.route_53_config.aws_region
}


resource "autoglue_credential" "route53" {
  name        = "${var.autoglue.autoglue_cluster_name}-route53-credential"
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

resource "autoglue_domain" "captain" {
  domain_name   = var.autoglue.route_53_config.domain_name
  credential_id = autoglue_credential.route53.id
  zone_id       = var.autoglue.route_53_config.zone_id
}

resource "autoglue_record_set" "cluster_record" {
  domain_id = autoglue_domain.captain.id
  name      = "ctrp"
  type      = "A"
  ttl       = 60
  values    = flatten([for name, pool in module.node_pool : pool.role == "master" ? pool.master_private_ips : []])
}