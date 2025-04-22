terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  environment             = var.environment
  aws_region              = var.aws_region
  vpc_cidr                = var.vpc_cidr
  public_subnet_cidr_az1  = var.public_subnet_cidr_az1
  public_subnet_cidr_az2  = var.public_subnet_cidr_az2
  private_subnet_cidr_az1 = var.private_subnet_cidr_az1
  private_subnet_cidr_az2 = var.private_subnet_cidr_az2
}

module "iam" {
  source = "./modules/iam"

  environment = var.environment
  vpc_id      = module.vpc.vpc_id
}

module "eks" {
  source = "./modules/eks"

  environment                 = var.environment
  cluster_name                = var.cluster_name
  eks_version                 = var.eks_version
  eks_cluster_role_arn        = module.iam.eks_cluster_role_arn
  eks_cluster_security_group_id = module.iam.eks_cluster_security_group_id
  private_subnet_ids          = module.vpc.private_subnet_ids
  fargate_pod_execution_role_arn = module.iam.fargate_pod_execution_role_arn
}

# data "aws_eks_cluster_auth" "main" {
#   name = module.eks.cluster_name # Changed line
# }

data "aws_eks_cluster_auth" "main" {
  name = module.eks.cluster_name # Changed line
}

resource "kubernetes_config_map" "aws_auth" {
  provider = kubernetes
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = {
    mapRoles = jsonencode([
      {
        rolearn  = module.iam.fargate_pod_execution_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      },
    ])
    mapUsers = jsonencode([
      {
        userarn  = "arn:aws:iam::273354635930:user/aws-eks-user"
        username = "aws-eks-user"
        groups   = ["system:masters"]
      },
    ])
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  token                  = data.aws_eks_cluster_auth.main.token
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    token                  = data.aws_eks_cluster_auth.main.token
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  }
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID of the VPC"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "List of private subnet IDs"
}

output "eks_cluster_id" {
  value       = module.eks.cluster_id
  description = "ID of the EKS cluster"
}

output "eks_cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "Endpoint of the EKS cluster"
}

output "eks_cluster_kubeconfig_certificate_authority_data" {
  value       = module.eks.cluster_certificate_authority_data
  description = "Certificate authority data for kubeconfig"
}

output "cluster_name" {
  value       = module.eks.cluster_name
  description = "Name of the EKS cluster"
}