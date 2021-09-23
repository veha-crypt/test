# Usage

<!--- BEGIN_TF_DOCS --->
VPC EKS Network - Terraform Module  
This module allows to create network components for EKS

## Requirements

| Name | Version |
|------|---------|
| aws | ~> 3.46.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.46.0 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) |
| [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) |
| [aws_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) |
| [aws_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) |
| [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) |
| [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) |
| [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) |
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr\_block | CIDR block for the VPC | `string` | n/a | yes |
| db\_subnets | A map of the subnets cidr blocks and avz for database | `map(map(any))` | `{}` | no |
| enable\_dns\_hostnames | A boolean flag to enable/disable DNS hostname in the VPC | `string` | n/a | yes |
| enable\_dns\_support | A boolean flag to enable/disable DNS support in the VPC | `string` | n/a | yes |
| environment | A name of environment | `string` | n/a | yes |
| instance\_tenancy | A tenancy option for instances launched into the VPC | `string` | n/a | yes |
| name | A name of application | `string` | n/a | yes |
| public\_subnets | A map of the subnets cidr blocks and avz for public access | `map(map(any))` | `{}` | no |
| region | AWS region name for the VPC | `string` | n/a | yes |
| worker\_subnets | A map of the subnets cidr blocks and avz for worker nodes | `map(map(any))` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws\_vpc\_id | The ID of the VPC |
| db\_subnet\_ids | List of IDs of database subnets |
| public\_subnet\_ids | List of IDs of public subnets |
| worker\_subnet\_ids | List of IDs of worker subnets |

<!--- END_TF_DOCS --->

