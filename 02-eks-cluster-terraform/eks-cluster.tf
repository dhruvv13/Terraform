module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "myapp-eks-cluster"
  cluster_version = "1.31"

  cluster_endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  vpc_id                   = module.myapp-vpc.vpc_id
  subnet_ids               = module.myapp-vpc.private_subnets
  control_plane_subnet_ids = module.myapp-vpc.private_subnets

  eks_managed_node_groups = {
    worker-group-1 = {
      instance_types = ["t3.medium"]
      min_size       = 1
      max_size       = 3
      desired_size   = 2
    }
  }

  tags = {
    environment = "development"
    application = "myapp"
  }
}