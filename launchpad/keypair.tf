variable "aws_key_name" {
  default = "aws-test"
}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.aws_key_name
  public_key = file("~/.ssh/${var.aws_key_name}.pub")
}