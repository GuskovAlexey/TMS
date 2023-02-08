output "pub_ip_bastion" {
  value = aws_instance.bastion.public_ip
}

output "sg_allow_ssh_from_bastion" {
  value = aws_security_group.allow_ssh_from_bastion.id
}