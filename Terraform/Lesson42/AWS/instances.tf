resource "aws_instance" "instance_front" {
  count         = "${var.ec2_count_front}"
  ami           = "${var.ec2_ami}"
  instance_type = "${var.ec2_type_front}"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.sg_frontend.id]
  subnet_id =  aws_subnet.public_subnets[count.index].id
  depends_on = [aws_security_group.sg_frontend]
  key_name = "${var.key_pairs_ec2}"

  tags = {
    Name = "Front Instance"
  }
}
resource "aws_instance" "instance_back" {
  count         = "${var.ec2_count_back}"
  ami           = "${var.ec2_ami}"
  instance_type = "${var.ec2_type_back}"
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.sg_backend.id]
  subnet_id =  aws_subnet.private_subnets[count.index].id
  depends_on = [aws_security_group.sg_backend]
  key_name = "${var.key_pairs_ec2}"

  tags = {
    Name = "Back Instance"
  }
}
