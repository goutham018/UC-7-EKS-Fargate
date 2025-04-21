output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster.arn
  description = "ARN of the EKS cluster IAM role"
}

output "fargate_pod_execution_role_arn" {
  value       = aws_iam_role.fargate_pod_execution.arn
  description = "ARN of the IAM role for Fargate Pod execution"
}

output "eks_cluster_security_group_id" {
  value = aws_security_group.eks_cluster.id
  description = "ID of the EKS cluster security group"
}