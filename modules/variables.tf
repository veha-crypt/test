variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC"
  type        = string
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostname in the VPC"
  type        = string
}

variable "name" {
  description = "A name of application"
  type        = string
}

variable "public_subnets" {
  description = "A map of the subnets cidr blocks and avz for public access"
  type        = map(map(any))
  default     = {}
}

variable "worker_subnets" {
  description = "A map of the subnets cidr blocks and avz for worker nodes"
  type        = map(map(any))
  default     = {}
}

variable "db_subnets" {
  description = "A map of the subnets cidr blocks and avz for database"
  type        = map(map(any))
  default     = {}
}

variable "environment" {
  description = "A name of environment"
  type        = string
}

variable "region" {
  description = "AWS region name for the VPC"
  type        = string
}
