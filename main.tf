module "iam" {
  source = "./modules/iam"
}

module "ec2" {
  source              = "./modules/ec2"
  ami                 = var.ami
  instance_type       = var.instance_type
  iam_instance_profile = module.iam.instance_profile_name
  tags                = var.ec2_tags
}

module "ssm" {
  source       = "./modules/ssm"
  document_name = var.document_name
  chef_commands = var.chef_commands
  instance_id  = module.ec2.instance_id
}
module "vpc" {
  source = "./modules/vpc"
}