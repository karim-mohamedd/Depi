module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.name
  cluster_version = "1.30"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns                = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.public_subnets
  control_plane_subnet_ids = module.vpc.private_subnets

  
  eks_managed_node_group_defaults = {
    instance_types = ["t4g.small"]
    
    attach_cluster_primary_security_group = true

  }

  eks_managed_node_groups = {
    depi-node-group = {

      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t4g.small"]

      min_size     = 2
      max_size     = 3
      desired_size = 2
    }
  }

  
  #enable_cluster_creator_admin_permissions = true

  

  tags = {
    Environment = "depi"
  }
}


/*
data "aws_iam_role" "depi" {
  name = "eks"
}
*/