# terraform {
#   required_providers {
#     kubernetes = {
#       source  = "hashicorp/kubernetes"
#       version = ">= 2.0.0"  # Specify the version you need
#     }
#   }
# }

# data "aws_eks_cluster" "main" {
#   name = aws_eks_cluster.main.name
# }

# data "aws_eks_cluster_auth" "main" {
#   name = aws_eks_cluster.main.name
# }

# # Configure Kubernetes provider with data from the created EKS cluster
# provider "kubernetes" {
#   host                   = data.aws_eks_cluster.main.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.main.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.main.token
# }

resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = var.eks_cluster_role_arn
  vpc_config {
    subnet_ids              = var.private_subnet_ids
    security_group_ids      = [var.eks_cluster_security_group_id]
    endpoint_private_access = true
    endpoint_public_access  = false
  }

  version = var.eks_version

  # Remove direct module dependencies
  depends_on = []

  tags = {
    Environment = var.environment
    Name        = var.cluster_name
  }
}

resource "aws_eks_fargate_profile" "main" {
  cluster_name = aws_eks_cluster.main.name
  fargate_profile_name = "${var.environment}-fargate"
  pod_execution_role_arn = var.fargate_pod_execution_role_arn
  subnet_ids = var.private_subnet_ids

  selector {
    namespace = "default"
  }

  selector {
    namespace = "kube-system"
  }

  tags = {
    Environment = var.environment
    Name        = "${var.environment}-fargate-profile"
  }

  depends_on = [aws_eks_cluster.main]
}