variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "ami" {
  description = "AMI to use for the EC2 instance (ensure it has SSM Agent installed)"
  type        = string
  default    = "ami-085ad6ae776d8f09c" # Example AMI, replace with a valid one=
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ec2_tags" {
  description = "Tags to apply to the EC2 instance"
  type        = map(string)
  default = {
    Name = "chef-instance"
  }
}

variable "document_name" {
  description = "Name of the SSM document"
  type        = string
  default     = "DeployChefCookbooksv2"
}

variable "chef_commands" {
  description = "List of commands to run the Chef client"
  type        = list(string)
  default     = [
    "sudo chef-client -o 'recipe[cookbook::default]'"
  ]
}
