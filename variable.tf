variable "environment" {
  type        = string
  description = "Environment name (e.g., dev)"
  default     = "dev"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_az1" {
  type        = string
  description = "CIDR block for the public subnet in AZ-a"
  default     = "10.0.1.0/24"
}

variable "public_subnet_cidr_az2" {
  type        = string
  description = "CIDR block for the public subnet in AZ-b"
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr_az1" {
  type        = string
  description = "CIDR block for the private subnet in AZ-a"
  default     = "10.0.11.0/24"
}

variable "private_subnet_cidr_az2" {
  type        = string
  description = "CIDR block for the private subnet in AZ-b"
  default     = "10.0.12.0/24"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
  default     = "my-eks-cluster"
}

variable "eks_version" {
  type        = string
  description = "Kubernetes version for the EKS cluster"
  default     = "1.28"
}