resource "aws_iam_role" "eks_cluster" {
  name = "${var.environment}-eks-cluster-role"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })

  tags = {
    Name = "${var.environment}-eks-cluster-role"
  }
}

resource "aws_iam_policy_attachment" "eks_cluster_policy" {
  name       = "${var.environment}-eks-cluster-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_policy_attachment" "eks_vpc_cni_policy" {
  name       = "${var.environment}-eks-vpc-cni-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSCNIPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role" "fargate_pod_execution" {
  name = "${var.environment}-fargate-pod-execution-role"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })

  tags = {
    Name = "${var.environment}-fargate-pod-execution-role"
  }
}

resource "aws_iam_policy_attachment" "fargate_pod_execution_policy" {
  name       = "${var.environment}-fargate-pod-execution-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate_pod_execution.name
}

resource "aws_security_group" "eks_cluster" {
  name_prefix = "${var.environment}-eks-cluster-sg-"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.environment}-eks-cluster-sg"
  }
}