# Usage

<!--- BEGIN_TF_DOCS --->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) |
| [aws_autoscaling_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) |
| [aws_launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment | A name of environment | `string` | n/a | yes |
| ingress | A list of ingress blocks | `list(map(string))` | <pre>[<br>  {<br>    "cidr_blocks": "0.0.0.0/0",<br>    "from_port": "22",<br>    "protocol": "tcp",<br>    "to_port": "22"<br>  }<br>]</pre> | no |
| instance\_type | The size of instance to launch | `string` | `"t2.small"` | no |
| key\_name | The key name that should be used for the instance | `string` | n/a | yes |
| public\_subnets | A list of the subnet ids | `list` | n/a | yes |
| region | AWS region name for the VPC | `string` | n/a | yes |
| vpc\_id | ID of the VPC where to create security group | `string` | n/a | yes |

## Outputs

No output.

<!--- END_TF_DOCS --->

