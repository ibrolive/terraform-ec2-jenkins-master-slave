output "id" {
  description = "List of IDs of instances"
  value       = aws_instance.jenkins_master.*.id
}

output "arn" {
  description = "List of ARNs of instances"
  value       = aws_instance.jenkins_master.*.arn
}

output "password_data" {
  description = "List of Base-64 encoded encrypted password data for the instance"
  value       = aws_instance.jenkins_master.*.password_data
}

output "public_dns" {
  description = "List of public DNS names assigned to the instances. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = aws_instance.jenkins_master.*.public_dns
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = aws_instance.jenkins_master.*.public_ip
}
