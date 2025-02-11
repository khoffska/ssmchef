variable "ami" {
  description = "AMI to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "iam_instance_profile" {
  description = "IAM instance profile name"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the instance"
  type        = map(string)
  default     = {
    Name = "chef-instance"
  }
}
