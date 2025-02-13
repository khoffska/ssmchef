resource "aws_ssm_association" "chef_association" {
  name = "AWS-ApplyChefRecipes"

  targets {
    key    = "InstanceIds"
    values = [var.instance_id]
  }

  parameters = {
    SourceType = "S3"
    SourceInfo = jsonencode({
      path = "https://chefcookbooks9999.s3.amazonaws.com/dockerwrapper2.tar.gz"
    })
    ChefVersion             = "16"
    RunCommand              = "False"
    RunList                = "recipe[docker_wrapper2::default]"    
    ChefClientVersion      = "16"
    WhyRun                 = "False"
    ComplianceSeverity     = "None"
    ComplianceType         = "Custom:Chef"
    ChefExecutionTimeout   = "3600"
  }
}
