
terraform {
    required_version = ">= 0.14.3"
}

provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "jenkins_master" {
    ami                         = "ami-0089b31e09ac3fffc" # Amaxon Linux 2 AMI from eu-west-2 region
    count                       = 1
    instance_type               = var.jenkins_master
    key_name                    = var.key_name
    associate_public_ip_address = true
    vpc_security_group_ids      = [module.http_sg.this_security_group_id] #["sg-0f89322a79aa4a404"] # ensure this Security Group has port 9091 opened
    user_data                   = templatefile("${path.cwd}/master-bootstrap.tmpl", {})

    tags = {
        Name            = "Jenkins-Master"
        ProvisionedBy   = "Terraform"
    }
}


resource "aws_instance" "jenkins_slave" {
    ami                         = "ami-0089b31e09ac3fffc" # Amaxon Linux 2 AMI from eu-west-2 region
    count                       = 2
    instance_type               = var.jenkins_slave
    key_name                    = var.key_name
    associate_public_ip_address = true
    vpc_security_group_ids      = [module.http_sg.this_security_group_id] #["sg-0f89322a79aa4a404"] # ensure this Security Group has port 9091 opened
    user_data                   = templatefile("${path.cwd}/slave-bootstrap.tmpl", {})

    tags = {
        Name            = "Jenkins-Slave-${count.index+1}"
        ProvisionedBy   = "Terraform"
    }
}

resource "aws_key_pair" "JenkinsKeyPair" {
  key_name   = "JenkinsKeyPair"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 ${var.email}"
}