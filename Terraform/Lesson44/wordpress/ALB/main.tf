data "terraform_remote_state" "network" {
    backend = "local"

    config = {
        path = "../network/terraform.tfstate"
    }
}

resource "aws_security_group" "front_alb_sg" {
  name        = "front_alb_sg"
  description = "Security group for ALB front"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "front_alb_sg"
  }
}

resource "aws_lb" "alb_front" {
  name               = "alb-frontend"
  internal           = false
  security_groups    = [aws_security_group.front_alb_sg.id]
  subnets            = data.terraform_remote_state.network.outputs.public_subnets
  depends_on = [ aws_security_group.front_alb_sg ]
  tags = {
    Name = "alb_frontend"
  }
}

resource "aws_lb_listener" "front_alb_lisener" {
  load_balancer_arn = aws_lb.alb_front.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg_alb_front.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "tg_alb_front" {
  name     = "front-tg-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc_id
}

resource "aws_security_group" "back_alb_sg" {
  name        = "back_alb_sg"
  description = "Security group for ALB back"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "back_alb_sg"
  }
}

resource "aws_lb" "alb_back" {
  name               = "alb-backend"
  internal           = false
  security_groups    = [aws_security_group.back_alb_sg.id]
  subnets            = data.terraform_remote_state.network.outputs.private_subnets
  depends_on = [ aws_security_group.back_alb_sg ]
  tags = {
    Name = "alb_backend"
  }
}

resource "aws_lb_listener" "back_alb_lisener" {
  load_balancer_arn = aws_lb.alb_back.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg_alb_back.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "tg_alb_back" {
  name     = "back-tg-alb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.terraform_remote_state.network.outputs.vpc_id
}