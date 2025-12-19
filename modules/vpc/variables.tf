variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "gloco-vpc"
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "gloco-subnet"
}

variable "region" {
  description = "The region where the network resources are created."
  type        = string
}