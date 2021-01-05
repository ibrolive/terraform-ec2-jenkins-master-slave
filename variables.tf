variable "email" {
  description = "Email to use in the key pair"
  type        = string
  default     = "email@domain.com"
}
variable "aws_region" {
  default = "eu-west-2"
}
variable "key_name" {
  description = "Key name to be used with the launched EC2 instances."
  default     = "JenkinsKeyPair"
}
variable "jenkins_master" {
  type    = string
  default = "t2.micro"
}
variable "jenkins_slave" {
  type    = string
  default = "t2.micro"
}