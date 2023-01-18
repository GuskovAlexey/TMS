output "ec2_global_ips_front" {
  value = "${aws_instance.instance_front.*.public_ip}"
}

output "ec2_global_ips_back" {
  value = "${aws_instance.instance_back.*.public_ip}"
}

output "sg_open_ports_front" {
  value = [for ingress in aws_security_group.sg_frontend.ingress: "${ingress.from_port}-${ingress.to_port}/${ingress.protocol}"]
}

output "sg_open_ports_back" {
  value = [for ingress in aws_security_group.sg_backend.ingress: "${ingress.from_port}-${ingress.to_port}/${ingress.protocol}"]
}