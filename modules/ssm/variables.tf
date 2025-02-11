variable "document_name" {
  description = "Name of the SSM document"
  type        = string
  default     = "DeployChefCookbooks"
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
