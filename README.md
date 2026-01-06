# opentofu-module-GlueKube-HetznerCloud
Managed by github-org-manager


```
terraform.tfvars
```HCL
provider_credentials = {
  name   = "hetzner"
  token  = ""
  region = ""
}
autoglue_cluster_name = ""

autoglue_key        = ""
autoglue_org_secret = ""
autoglue_base_url   = "https://autoglue.glueopshosted.com/api/v1"

aws_access_key_id     = ""
aws_secret_access_key = ""
route53_region        = ""
route53_zone_id       = ""
domain_name           = ""

```

main.tf 
```HCL
module "captain" {
  source                = "git::https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud.git"
  gluekube_docker_image = "ghcr.io/glueops/gluekube"
  gluekube_docker_tag   = "v0.0.15-rc9"
  vpc_cidr_block        = "10.0.0.0/16"
  subnet_cidr           = "10.0.0.0/24"
  region                = var.provider_credentials.region

  # control_plane_endpoint_dns = "ctrp"
  provider_credentials = var.provider_credentials
  autoglue = {
    autoglue_cluster_name = var.autoglue_cluster_name

    credentials = {
      autoglue_key        = var.autoglue_key
      autoglue_org_secret = var.autoglue_org_secret
      base_url            = var.autoglue_base_url
    }
    route_53_config = {
      aws_access_key_id     = var.aws_access_key_id
      aws_secret_access_key = var.aws_secret_access_key
      aws_region            = var.route53_region
      domain_name           = var.domain_name
      zone_id               = var.route53_zone_id
      credential_id         = var.autoglue_credentials_id
    }
  }
  bastion = {
    instance_type = "cpx32"
    image         = "ubuntu-24.04"
  }

  node_pools = [
    {
      "instance_type" : "cpx32",
      "role" : "master",
      "name" : "master-node-pool",
      "image" : "ubuntu-24.04",
      "node_count" : 3,

      "kubernetes_labels" : {},
      "kubernetes_taints" : []
    },
    {
      "instance_type" : "cpx32",
      "role" : "worker",
      "name" : "glueops-platform-node-pool-1",
      "image" : "ubuntu-24.04",

      "node_count" : 2,

      "kubernetes_labels" : {
        "glueops.dev/role" : "glueops-platform"
      },
      "kubernetes_taints" : [
        {
          key    = "glueops.dev/role"
          value  = "glueops-platform"
          effect = "NoSchedule"
        }
      ]
    },
    {
      "instance_type" : "cpx32",
      "role" : "worker",
      "name" : "glueops-platform-node-pool-argocd-app-controller",
      "node_count" : 2,
      "image" : "ubuntu-24.04",


      "kubernetes_labels" : {
        "glueops.dev/role" : "glueops-platform-argocd-app-controller"
      },
      "kubernetes_taints" : [
        {
          key    = "glueops.dev/role"
          value  = "glueops-platform-argocd-app-controller"
          effect = "NoSchedule"
        }
      ]
    },
    {
      "instance_type" : "cpx32",
      "role" : "worker",
      "name" : "clusterwide-node-pool-1",
      "image" : "ubuntu-24.04",

      "node_count" : 2,

      "kubernetes_labels" : {},
      "kubernetes_taints" : []
    },
    
    {
      "instance_type" : "cpx32",
      "role" : "worker",
      "name" : "node-pool-platform-loadbalancer-2",
      "image" : "ubuntu-24.04",

      "node_count" : 2,

      "kubernetes_labels" : {
        "glueops.dev/role" : "glueops-platform",
        "use-as-loadbalancer" : "platform"
      },
      "kubernetes_taints" : []
    },
    {
      "instance_type" : "cpx32",
      "role" : "worker",
      "name" : "node-pool-public-loadbalancer",
      "image" : "ubuntu-24.04",

      "node_count" : 2,

      "kubernetes_labels" : {
        "glueops.dev/role" : "glueops-platform",
        "use-as-loadbalancer" : "public"
      },
      "kubernetes_taints" : []
    },
  ]
}

```