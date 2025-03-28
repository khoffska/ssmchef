variable "document_name" {
  description = "Name of the SSM document"
  type        = string
  default     = "DeployChefCookboooks"
}

variable "chef_commands" {
  description = "List of commands to run the Chef client"
  type        = list(string)
  default     = [
    "sudo chef-client -o 'recipe[cookbook::default]'"
  ]
}

variable "instance_id" {
  description = "ID of the EC2 instance to associate with the SSM document"
  type        = string
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
        runlist  = "recipe[emacs::default]"
        tar_file = "auditd.tar.gz"
      },
      {
        runlist  = "recipe[starter::default]"
        tar_file = "chefcloudsetup.tar.gz"
      },
      {
        runlist  = "recipe[fail2ban::default]"
        tar_file = "fail2ban.tar.gz"
      },
      {
        runlist  = "recipe[docker_wrapper2::default]"
        tar_file = "dockerwrapper2.tar.gz"
      }
    ]
    # Add more environments as needed
  }
}