resource "aws_launch_template" "ec2_launch" {
  name_prefix   = "ec2_launch"
  image_id      = "ami-0120e0e7231daa18b" # To note: AMI is specific for each region
  instance_type = "t2.micro"
  user_data     = filebase64("./scripts/user_data.sh")

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = aws_subnet.private[0].id
    security_groups             = [aws_security_group.ec2_asg.id]
  }
  monitoring {
    enabled = true
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "dev-ec2-instance" # Name for the EC2 instances
    }
  }
}

resource "aws_autoscaling_group" "sh_asg" {
  # no of instances
  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  # Connect to the target group
  target_group_arns = [aws_lb_target_group.alb_front_tg.arn]

  vpc_zone_identifier = [ # Creating EC2 instances in private subnet
    aws_subnet.private[0].id
  ]

  launch_template {
    id      = aws_launch_template.ec2_launch.id
    version = "$Latest"
  }
}