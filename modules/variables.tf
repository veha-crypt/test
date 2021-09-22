
variable "public_subnets" {
  description = "A list of the subnet ids"
  type        = list
}

variable "environment" {
  description = "A name of environment"
  type        = string
}

variable "region" {
  description = "AWS region name for the VPC"
  type        = string
}

variable "instance_type" {
  description = "The size of instance to launch"
  type        = string
  default     = "t2.small"
}

variable "key_name" {
  description = "The key name that should be used for the instance"
  type        = string
}
variable "ingress" {
  description = "A list of ingress blocks"
  type        = list(map(string))
  default = [
    {
      from_port   = "22"
      to_port     = "22"
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
}
