################################################################################
# AMI
################################################################################

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name      = "name"
    values    = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name      = "virtualization-type"
    values    = ["hvm"]
  }

  owners      = ["099720109477"]
}

################################################################################
# Security Group
################################################################################
#tfsec:ignore:aws-vpc-no-public-egress-sg
resource "aws_security_group" "bastion_sg" {

  vpc_id                    = var.vpc_id
  name                      = "bastion"
  description               = "Security group that allows SSH-access to bastion"
  egress {
    from_port               = 0
    to_port                 = 0
    protocol                = "-1"
    cidr_blocks             = ["0.0.0.0/0"]
  }

  dynamic "ingress" {
    for_each = var.ingress
    content {
      from_port             = ingress.value.from_port
      to_port               = ingress.value.to_port
      protocol              = ingress.value.protocol
      cidr_blocks           = ["${ingress.value.cidr_blocks}"]
    }
  }

  tags = merge(
    {
      "Name"                = format("%s", "bastion-${var.environment}-sg")
    },
    {
      "Environment"         = format("%s", var.environment)
    }
  )

}

################################################################################
# Launch template
################################################################################

resource "aws_launch_template" "bastion-lt" {

  name                      = "bastion"
  image_id                  = data.aws_ami.ubuntu.id
  instance_type             = var.instance_type
  key_name                  = var.key_name
  vpc_security_group_ids    = ["${aws_security_group.bastion_sg.id}"]

}

################################################################################
# Autoscaling group
################################################################################

resource "aws_autoscaling_group" "bastion" {

  name                      = "${var.environment}-bastion"
  min_size                  = 1
  max_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 300
  vpc_zone_identifier       = var.public_subnets

  launch_template  {
    id                      = aws_launch_template.bastion-lt.id
    version                 = "$Latest"
  }

  lifecycle {
    create_before_destroy   = true
  }

  tags = concat(
    [
      {
        key                 = "Name"
        value               = "${var.environment}-bastion"
        propagate_at_launch = true
      },
      {
        key                 = "Environment"
        value               = var.environment
        propagate_at_launch = true
      }
    ]
  )

}
