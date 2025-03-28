module "vpc" {
  source = "../vpc" # Adjust this path based on your structure
}
resource "aws_instance" "chef_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  iam_instance_profile = var.iam_instance_profile
  subnet_id             = module.vpc.private_subnet_ids[0]
  user_data = <<-EOF
    #!/bin/bash
    # Install Chef Client using the official Omnitruck installer
    curl -L https://omnitruck.chef.io/install.sh | sudo bash
  EOF
  tags = var.tags
  associate_public_ip_address = false 
}
