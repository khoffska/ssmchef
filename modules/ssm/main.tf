resource "aws_ssm_association" "chef_association" {
  name = "AWS-ApplyChefRecipes"

  targets {
    key    = "InstanceIds"
    values = [var.instance_id]
  }

  parameters = {
    SourceType = "S3"
    SourceInfo = jsonencode({path = "https://chefcookbooks9999.s3.amazonaws.com/chefcloudsetup.tar.gz"})
    RunList                = "recipe[starter::default]"    
    ChefClientVersion      = "16"
    WhyRun                 = "False"
    ComplianceSeverity     = "None"
    ComplianceType         = "Custom:Chef"
    ChefExecutionTimeout   = "3600"
  }
}
locals {
  # Flatten the map into a list of objects with an environment key.
  env_recipe_flat = flatten([
    for env, recipes in var.env_recipes : [
      for recipe in recipes : {
        env      = env
        runlist  = recipe.runlist
        tar_file = recipe.tar_file
      }
    ]
  ])
}

resource "aws_ssm_association" "chef_association2" {
  # Create a unique key for each association by combining the environment and index.
  for_each = { for idx, rec in local.env_recipe_flat : "${rec.env}-${idx}" => rec }

  name = "AWS-ApplyChefRecipes"

  targets {
    key    = "tag:Environment"
    values = [each.value.env]
  }

  parameters = {
    SourceType           = "S3"
    SourceInfo           = jsonencode({ path = "https://chefcookbooks9999.s3.amazonaws.com/${each.value.tar_file}" })
    RunList              = each.value.runlist
    ChefClientVersion    = "16"
    WhyRun               = "False"
    ComplianceSeverity   = "None"
    ComplianceType       = "Custom:Chef"
    ChefExecutionTimeout = "3600"
  }
}