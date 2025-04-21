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

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_cni_policy,
  ]

  tags = {
    Environment = var.environment
    Name        = var.cluster_name
  }
}

resource "aws_eks_fargate_profile" "main" {
  cluster_name = aws_eks_cluster.main.name
  name_prefix  = "${var.environment}-fargate"
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