output "eks_cluster_id" {
  value       = aws_eks_cluster.main.id
  description = "ID of the EKS cluster"
}

output "eks_cluster_endpoint" {
  value       = aws_eks_cluster.main.endpoint
  description = "Endpoint of the EKS cluster"
}

output "eks_cluster_kubeconfig_certificate_authority_data" {
  value       = aws_eks_cluster.main.certificate_authority.0.data
  description = "Certificate authority data for kubeconfig"
}