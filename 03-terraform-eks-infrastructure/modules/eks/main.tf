# This module will wait until the myapp-eks module is created since myapp-eks.oid_provider_arn is used in it.
module "ebs_csi_driver_irsa" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts"

  name = "ebs-csi"

  attach_ebs_csi_policy = true

  oidc_providers = {
    this = {
      provider_arn               = module.my_eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:ebs-csi-controller-sa"]
    }
  }

  tags = var.common_tags
}

module "my_eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.10.1"

  // Module configuration
  name = "${var.cluster_name}"
  kubernetes_version = "1.31"

  # EKS Addons
  addons = {
    coredns = {}

    // Installs the add -> ebs-csi-controller pod will have ebs-csi-controller-sa
    // ebs-csi-controller-sa will be annotated with the role arn specified below.
    // The IAM role is created by the ebs_csi_driver_irsa automatically.
    aws-ebs-csi-driver = {
      service_account_role_arn = module.ebs_csi_driver_irsa.arn
    }
    kube-proxy = {}
    // assigns private VPC ips (from subnet range) to all pods.
    vpc-cni = {
      before_compute = true
    }
  }

  vpc_id = var.vpc_id

  // List of private subnets where worker nodes are started.
  subnet_ids = var.private_subnets
  endpoint_public_access = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    "${var.name_prefix}" = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
  tags = var.common_tags
}



