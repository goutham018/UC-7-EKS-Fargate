terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" { # Changed "network" to "vpc" here
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
  vpc_id      = module.vpc.vpc_id # Changed "network" to "vpc" here
}

module "eks" {
  source = "./modules/eks"

  environment                 = var.environment
  cluster_name                = var.cluster_name
  eks_version                 = var.eks_version
  eks_cluster_role_arn        = module.iam.eks_cluster_role_arn
  eks_cluster_security_group_id = module.iam.eks_cluster_security_group_id
  private_subnet_ids          = module.vpc.private_subnet_ids # Changed "network" to "vpc" here
  fargate_pod_execution_role_arn = module.iam.fargate_pod_execution_role_arn
}

output "vpc_id" {
  value       = module.vpc.vpc_id # Changed "network" to "vpc" here
  description = "ID of the VPC"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids # Changed "network" to "vpc" here
  description = "List of public subnet IDs"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids # Changed "network" to "vpc" here
  description = "List of private subnet IDs"
}

output "eks_cluster_id" {
  value       = module.eks.eks_cluster_id
  description = "ID of the EKS cluster"
}

output "eks_cluster_endpoint" {
  value       = module.eks.eks_cluster_endpoint
  description = "Endpoint of the EKS cluster"
}

output "eks_cluster_kubeconfig_certificate_authority_data" {
  value       = module.eks.eks_cluster_kubeconfig_certificate_authority_data
  description = "Certificate authority data for kubeconfig"
}