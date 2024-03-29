data "terraform_remote_state" "network" {
    backend = "local"

    config = {
        path = "../network/terraform.tfstate"
    }
}

data "aws_launch_template" "lt_front" {
  name = "front-template"
}

data "aws_launch_template" "lt_back" {
  name = "back-template"
}

data "aws_lb_target_group" "front_tg" {
  name = "front-tg-alb"
  }

data "aws_lb_target_group" "back_tg" {
    name   =  "back-tg-alb"
  }

resource "aws_autoscaling_group" "asg_frontend" {
  name                      = "asg_front"
  max_size                  = 4
  min_size                  = 1
  desired_capacity          = 1
  launch_template {
    id = data.aws_launch_template.lt_front.id
  }
  vpc_zone_identifier       = data.terraform_remote_state.network.outputs.public_subnets
  target_group_arns = [ data.aws_lb_target_group.front_tg.arn ]
  tag {
    key                 = "Name"
    value               = "ec2instance_front}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "asg_backend" {
  name                      = "asg_back"
  max_size                  = 5
  min_size                  = 2
  desired_capacity          = 2
  launch_template {
    id = data.aws_launch_template.lt_back.id
  }
  vpc_zone_identifier       = data.terraform_remote_state.network.outputs.private_subnets
  target_group_arns = [ data.aws_lb_target_group.back_tg.arn ]
  tag {
    key                 = "Name"
    value               = "ec2instance_back"
    propagate_at_launch = true
  }
}

