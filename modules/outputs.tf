output "aws_vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.eks_vpc.id
}

output "worker_subnet_ids" {
  description = "List of IDs of worker subnets"
  value       = [ for id in sort(keys(var.worker_subnets)) : aws_subnet.worker_subnet[id].id ]
}

output "db_subnet_ids" {
  description = "List of IDs of database subnets"
  value       = [ for id in sort(keys(var.db_subnets)) : aws_subnet.db_subnet[id].id ]
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       =  [ for id in sort(keys(var.public_subnets)) :  aws_subnet.public_subnet[id].id ]
}
