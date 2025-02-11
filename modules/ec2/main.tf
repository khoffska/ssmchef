resource "aws_instance" "chef_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  iam_instance_profile = var.iam_instance_profile

  tags = var.tags
}
