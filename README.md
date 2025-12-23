# opentofu-module-GlueKube-HetznerCloud
Managed by github-org-manager


main.tf 
```HCL
module "captain" {
  source                = "https://github.com/GlueOps/opentofu-module-GlueKube-HetznerCloud.git"
  hcloud_token          = ""
  gluekube_docker_image = "ghcr.io/glueops/gluekube"
  gluekube_docker_tag   = "v0.0.12"
  vpc_cidr_block        = "10.0.0.0/16"
  subnet_cidr           = "10.0.0.0/24"
  region                = "hel1"
  autoglue = {
    autoglue_cluster_name = "demo"

    credentials = {
      autoglue_org_id     = ""
      autoglue_key        = ""
      autoglue_org_secret = ""
      base_url            = "https://autoglue.glueopshosted.com/api/v1"
    }
    route_53_config = {
      aws_access_key_id     = ""
      aws_secret_access_key = ""
      aws_region            = ""
      domain_name           = ""
      zone_id               = ""
    }
  }
  node_pools = [
    {
      "instance_type" : "cpx21",
      "role" : "master",
      "name" : "node-pool",
      "node_count" : 3,
      "disk_size_gb" : 20,
      "kubernetes_labels" : {},
      "kubernetes_taints" : []
    },
    {
      "instance_type" : "cpx21",
      "role" : "worker",
      "name" : "glueops-platform-node-pool-1",
      "node_count" : 4,
      "disk_size_gb" : 20,
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
      "instance_type" : "cpx21",
      "role" : "worker",
      "name" : "glueops-platform-node-pool-argocd-app-controller",
      "node_count" : 2,
      "disk_size_gb" : 20,
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
      "instance_type" : "cpx21",
      "role" : "worker",
      "name" : "clusterwide-node-pool-1",
      "node_count" : 2,
      "disk_size_gb" : 20,
      "kubernetes_labels" : {},
      "kubernetes_taints" : []
    },
    {
      "instance_type" : "cpx21",
      "role" : "worker",
      "name" : "node-pool-platform-loadbalancer",
      "node_count" : 2,
      "disk_size_gb" : 20,
      "kubernetes_labels" : {
        "glueops.dev/role" : "glueops-platform",
        "use-as-loadbalancer" : "platform"
      },
      "kubernetes_taints" : []
    },
    {
      "instance_type" : "cpx21",
      "role" : "worker",
      "name" : "node-pool-public-loadbalancer",
      "node_count" : 2,
      "disk_size_gb" : 20,
      "kubernetes_labels" : {
        "glueops.dev/role" : "glueops-platform",
        "use-as-loadbalancer" : "public"
      },
      "kubernetes_taints" : []
    },
  ]
  peering_configs = []
}
```