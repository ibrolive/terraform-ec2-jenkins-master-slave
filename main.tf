
terraform {
    required_version = ">= 0.14.3"
}

provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "jenkins_master" {
    ami                         = "ami-0089b31e09ac3fffc" # Amaxon Linux 2 AMI from eu-west-2 region
    count                       = 1
    instance_type               = "t2.micro"
    key_name                    = "JenkinsKeyPair"
    associate_public_ip_address = true
    vpc_security_group_ids      = ["sg-0f89322a79aa4a404"] # ensure this Security Group has port 9091 opened
    user_data                   = templatefile("${path.cwd}/master-bootstrap.tmpl", {})

    tags = {
        Name            = "Jenkins-Master"
        ProvisionedBy   = "Terraform"
    }
}


resource "aws_instance" "jenkins_slave" {
    ami                         = "ami-0089b31e09ac3fffc" # Amaxon Linux 2 AMI from eu-west-2 region
    count                       = 2
    instance_type               = "t2.micro"
    key_name                    = "JenkinsKeyPair"
    associate_public_ip_address = true
    vpc_security_group_ids      = ["sg-0f89322a79aa4a404"] # ensure this Security Group has port 9091 opened
    user_data                   = templatefile("${path.cwd}/slave-bootstrap.tmpl", {})

    tags = {
        Name            = "Jenkins-Slave-${count.index+1}"
        ProvisionedBy   = "Terraform"
    }
}