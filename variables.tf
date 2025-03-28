variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"
}

variable "ami" {
  description = "AMI to use for the EC2 instance (ensure it has SSM Agent installed)"
  type        = string
  default    = "ami-04b4f1a9cf54c11d0" # Example AMI, replace with a valid one=
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
    Environment = "Development"
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
variable "s3_cookbooks" {
  description = "Name of the S3 bucket to store cookbooks"
  type        = string
  default     = "chefcookbooks9999"
}
variable "env_recipes" {
  description = "Map of environment tag to a list of recipe objects, each with a runlist and its associated tar.gz file."
  type = map(list(object({
    runlist  = string
    tar_file = string
  })))
  default = {
    Development = [
      {
        runlist  = "recipe[auditd::default]"
        tar_file = "auditd.tar.gz"
      },
      {
        runlist  = "recipe[starter::default]"
        tar_file = "chefcloudsetup.tar.gz"
      },
      {
        runlist  = "recipe[docker::default]"
        tar_file = "docker-11.9.2.tar.gz"
      },
      {
        runlist  = "recipe[dockerwrapper::default]"
        tar_file = "dockerwrapper.tar.gz"
      },
      {
        runlist  = "recipe[dockerwrapper2::default]"
        tar_file = "dockerwrapper2.tar.gz"
      },
      {
        runlist  = "recipe[ntp::default]"
        tar_file = "ntp-5.2.3.tar.gz"
      }
    ]
    # Add more environments as needed
  }
}