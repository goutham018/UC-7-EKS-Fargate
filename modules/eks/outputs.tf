output "cluster_name" {
  value       = aws_eks_cluster.main.name
  description = "Name of the EKS cluster"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.main.endpoint
  description = "EKS cluster endpoint"
}

output "cluster_certificate_authority_data" {
  value       = aws_eks_cluster.main.certificate_authority.0.data
  description = "EKS cluster certificate authority data"
}

output "cluster_id" {
  value       = aws_eks_cluster.main.id
  description = "EKS cluster ID"
}