variable "environment" {
  type        = string
  description = "Environment name"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "eks_version" {
  type        = string
  description = "Version of Kubernetes for the EKS cluster"
}

variable "eks_cluster_role_arn" {
  type        = string
  description = "ARN of the IAM role for the EKS cluster"
}

variable "eks_cluster_security_group_id" {
  type        = string
  description = "Security group ID for the EKS cluster"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for the EKS cluster"
}

variable "fargate_pod_execution_role_arn" {
  type        = string
  description = "ARN of the IAM role for Fargate pod execution"
}