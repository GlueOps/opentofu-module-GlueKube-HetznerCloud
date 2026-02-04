<!-- BEGIN_TF_DOCS -->
# opentofu-module-GlueKube-HetznerCloud

This opentofu module deploys a Kubernetes cluster on Hetzner Cloud using GlueKube.

```hcl

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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_autoglue"></a> [autoglue](#requirement\_autoglue) | 0.10.0 |
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | 1.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_autoglue"></a> [autoglue](#provider\_autoglue) | 0.10.0 |
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | 1.57.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_node_pool"></a> [node\_pool](#module\_node\_pool) | ./modules/gluekube | n/a |

## Resources

| Name | Type |
|------|------|
| autoglue_cluster.cluster | resource |
| autoglue_cluster_bastion.bastion | resource |
| autoglue_cluster_captain_domain.domain | resource |
| autoglue_cluster_control_plane_record_set.ctrl_record | resource |
| autoglue_cluster_node_pools.autoglue_cluster_node_pools | resource |
| autoglue_domain.captain | resource |
| autoglue_record_set.cluster_record | resource |
| autoglue_server.bastion | resource |
| autoglue_ssh_key.bastion | resource |
| [hcloud_firewall.bastion_firewall](https://registry.terraform.io/providers/hetznercloud/hcloud/1.57.0/docs/resources/firewall) | resource |
| [hcloud_network.private_network](https://registry.terraform.io/providers/hetznercloud/hcloud/1.57.0/docs/resources/network) | resource |
| [hcloud_network_subnet.private_network_subnet](https://registry.terraform.io/providers/hetznercloud/hcloud/1.57.0/docs/resources/network_subnet) | resource |
| [hcloud_server.bastion](https://registry.terraform.io/providers/hetznercloud/hcloud/1.57.0/docs/resources/server) | resource |
| [hcloud_server_network.bastion_network](https://registry.terraform.io/providers/hetznercloud/hcloud/1.57.0/docs/resources/server_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoglue"></a> [autoglue](#input\_autoglue) | Configuration for the AutoGlue platform integration, including cluster naming, credentials, and Route53 DNS settings. | <pre>object({<br/>    autoglue_cluster_name = string<br/><br/>    credentials = object({<br/>      autoglue_key        = string<br/>      autoglue_org_secret = string<br/>      base_url            = string<br/>    })<br/><br/>    route_53_config = object({<br/>      aws_access_key_id     = string<br/>      aws_secret_access_key = string<br/>      aws_region            = string<br/>      domain_name           = string<br/>      zone_id               = string<br/>      credential_id         = string<br/>    })<br/>  })</pre> | n/a | yes |
| <a name="input_bastion"></a> [bastion](#input\_bastion) | Bastion configuration. | <pre>object({<br/>    instance_type = string<br/>    image         = string<br/>  })</pre> | n/a | yes |
| <a name="input_gluekube_docker_image"></a> [gluekube\_docker\_image](#input\_gluekube\_docker\_image) | n/a | `string` | `"ghcr.io/glueops/gluekube"` | no |
| <a name="input_gluekube_docker_tag"></a> [gluekube\_docker\_tag](#input\_gluekube\_docker\_tag) | n/a | `string` | `"v0.0.15-rc9"` | no |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | n/a | <pre>list(object({<br/>    name              = string<br/>    image             = string<br/>    node_count        = number<br/>    instance_type     = string<br/>    role              = string<br/>    kubernetes_labels = map(string)<br/>    kubernetes_taints = list(object({<br/>      key    = string<br/>      value  = string<br/>      effect = string<br/>    }))<br/><br/>  }))</pre> | n/a | yes |
| <a name="input_provider_credentials"></a> [provider\_credentials](#input\_provider\_credentials) | n/a | <pre>object({<br/>    name   = string<br/>    token  = string<br/>    region = string<br/>  })</pre> | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"hel1"` | no |
| <a name="input_subnet_cidr"></a> [subnet\_cidr](#input\_subnet\_cidr) | n/a | `string` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | The CIDR block for the VPC | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
