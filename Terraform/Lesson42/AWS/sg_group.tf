resource "aws_security_group" "sg_frontend" {
  name        = "sg_frontend"
  description = "Security group for the frontend instances"
  vpc_id = aws_vpc.main.id
  depends_on = [aws_vpc.main]

  dynamic "ingress" { 
    for_each = ["80", "443", "22"] 
    content { 
      from_port   = ingress.value 
      to_port     = ingress.value 
      protocol    = "tcp" 
      cidr_blocks = ["0.0.0.0/0"] 
    } 
  } 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = {
    Name = "Front SG"
  }
}
resource "aws_security_group" "sg_backend" {
  name        = "backend"
  description = "Security group for the backend instances"
  vpc_id = aws_vpc.main.id
  depends_on = [aws_vpc.main]
  
  dynamic "ingress" { 
    for_each = ["80", "22"] 
    content { 
      from_port   = ingress.value 
      to_port     = ingress.value 
      protocol    = "tcp" 
      security_groups = [ aws_security_group.sg_frontend.id ]
    } 
  } 
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  tags = {
    Name = "Back SG"
  }
}