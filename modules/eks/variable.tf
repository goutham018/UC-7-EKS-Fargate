variable "environment" {
  type        = string
  description = "Environment name (e.g., dev)"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_az1" {
  type        = string
  description = "CIDR block for the public subnet in AZ-a"
}

variable "public_subnet_cidr_az2" {
  type        = string
  description = "CIDR block for the public subnet in AZ-b"
}

variable "private_subnet_cidr_az1" {
  type        = string
  description = "CIDR block for the private subnet in AZ-a"
}

variable "private_subnet_cidr_az2" {
  type        = string
  description = "CIDR block for the private subnet in AZ-b"
}