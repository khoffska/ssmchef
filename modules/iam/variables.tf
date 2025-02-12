variable "role_name" {
  description = "IAM role name for EC2 instance"
  type        = string
  default     = "ec2_ssm_role2"
}

variable "instance_profile_name" {
  description = "Instance profile name for EC2 instance"
  type        = string
  default     = "ec2_ssm_profile2"
}

variable "ssm_policy_arn" {
  description = "ARN of the SSM managed instance policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
