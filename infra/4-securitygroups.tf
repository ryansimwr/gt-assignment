resource "aws_security_group" "ec2_asg" {
  name        = "dev-sg-lb-to-ec2"
  description = "Allow inbound and outbound traffic to EC2 instances from load balancer security group"
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.lb.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.this.id
}

resource "aws_security_group" "lb" {
  name        = "dev-sg-internet-to-lb"
  description = "Allow inbound and outbound traffic to load balancer from the internet."
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = aws_vpc.this.id
}