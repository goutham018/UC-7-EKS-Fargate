variable "environment" {
  type        = string
  description = "Environment name (e.g., dev)"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "eks_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster"
  default     = "1.28"
}

variable "eks_cluster_role_arn" {
  type        = string
  description = "ARN of the EKS cluster IAM role"
}

variable "eks_cluster_security_group_id" {
  type        = string
  description = "ID of the EKS cluster security group"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs where EKS control plane ENIs and Fargate pods will reside"
}

variable "fargate_pod_execution_role_arn" {
  type        = string
  description = "ARN of the IAM role for Fargate Pod execution"
}