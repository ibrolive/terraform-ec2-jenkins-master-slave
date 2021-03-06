#############################################################
# Data sources to get VPC and default security group details
#############################################################
data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = data.aws_vpc.default.id
}

###########################
# Security groups examples
###########################

#######
# HTTP
#######
module "http_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "dynamic-http-sg"
  description = "Security group with HTTP port open for everyone, and HTTPS open just for the default security group"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]

  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 9091
      to_port     = 9091
      protocol    = "tcp"
      description = "Jenkins ports"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}