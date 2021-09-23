/**
 * VPC EKS Network - Terraform Module
 * This module allows to create network components for EKS
 */

resource "aws_vpc" "eks_vpc" {

  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    {
      "Name"           = format("%s", "${var.environment}-${var.name}")
    },
    {
      "Environment"    = format("%s", var.environment)
    },
  )
}

resource "aws_internet_gateway" "igw" {

  vpc_id               = aws_vpc.eks_vpc.id

  tags = merge(
    {
      "Name"           = format("%s", "${var.environment}-${var.name}")
    },
    {
      "Environment"    = format("%s", var.environment)
    },
  )
}

resource "aws_eip" "nat-ip" {
  for_each             = var.public_subnets
  vpc                  = true

  tags = merge(
    {
      "Name"           = format("%s", "${var.environment}-${var.name}-${each.key}")
    },
    {
      "Environment"    = format("%s", var.environment)
    },
  )
}

resource "aws_nat_gateway" "ngw" {
  for_each             = var.public_subnets

  allocation_id        = aws_eip.nat-ip[each.key].id
  subnet_id            = aws_subnet.public_subnet[each.key].id

  tags = merge(
    {
      "Name"           = format("%s", "${var.environment}-${var.name}-${each.key}")
    },
    {
      "Environment"    = format("%s", var.environment)
    },
  )

  depends_on           = [aws_internet_gateway.igw]
}

resource "aws_subnet" "public_subnet" {
  for_each                = var.public_subnets

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.public_subnets[each.key]["cidr_block"]
  availability_zone       = "${var.region}${each.key}"
  map_public_ip_on_launch = var.public_subnets[each.key]["map_public_ip_on_launch"]

  tags = merge(
    {
      "Name"              = format("%s", "${var.environment}-${var.name}-public-${each.key}")
    },
    {
      "kubernetes.io/role/elb" = 1
    },
    {
      "Environment"       = format("%s", var.environment)
    },
  )
}

resource "aws_route_table" "public_rt" {

  vpc_id                  = aws_vpc.eks_vpc.id

  tags = merge(
    {
      "Name"              = format("%s", "${var.environment}-${var.name}-public-rt")
    },
    {
      "Environment"       = format("%s", var.environment)
    },
  )
}

resource "aws_route" "public_internet_gateway" {

  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

}

resource "aws_route_table_association" "public" {
  for_each               = var.public_subnets
  subnet_id              = aws_subnet.public_subnet[each.key].id
  route_table_id	 = aws_route_table.public_rt.id

}

resource "aws_route_table" "private_rt" {
  for_each               = var.public_subnets
  vpc_id                 = aws_vpc.eks_vpc.id

  tags = merge(
    {
      "Name"             = format("%s", "${var.environment}-${var.name}-private-rt-${each.key}")
    },
    {
      "Environment"      = format("%s", var.environment)
    },
  )
}

resource "aws_route" "private_nat_gateway" {
  for_each               = var.public_subnets

  route_table_id         = aws_route_table.private_rt[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw[each.key].id

}

resource "aws_route_table_association" "private" {
  for_each               = var.worker_subnets
  subnet_id              = aws_subnet.worker_subnet[each.key].id
  route_table_id         = aws_route_table.private_rt[each.key].id

}

resource "aws_subnet" "worker_subnet" {
  for_each                = var.worker_subnets

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.worker_subnets[each.key]["cidr_block"]
  availability_zone       = "${var.region}${each.key}"
  map_public_ip_on_launch = var.worker_subnets[each.key]["map_public_ip_on_launch"]

  tags = merge(
    {
      "Name"              = format("%s", "${var.environment}-${var.name}-worker-${each.key}")
    },
    {
      "kubernetes.io/role/internal-elb" = 1
    },
    {
      "Environment"       = format("%s", var.environment)
    },
  )
}

resource "aws_subnet" "db_subnet" {
  for_each                = var.db_subnets

  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.db_subnets[each.key]["cidr_block"]
  availability_zone       = "${var.region}${each.key}"

  tags = merge(
    {
      "Name"              = format("%s", "${var.environment}-${var.name}-db-${each.key}")
    },
    {
      "Environment"       = format("%s", var.environment)
    },
  )
}
