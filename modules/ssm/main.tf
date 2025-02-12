resource "aws_ssm_association" "chef_association" {
  name = "AWS-ApplyChefRecipes"

  targets {
    key    = "InstanceIds"
    values = [var.instance_id]
  }

  parameters = {
    SourceType             = "S3"
    # Ensure the S3 URL is publicly accessible or the instance can access it via appropriate IAM roles.
    SourceInfo             = "{\"path\":\"https://chefcookbooks9999.s3.amazonaws.com/docker-11.9.2.tar.gz\"}"
    RunList                = "recipe[docker::default]"  # Adjust to your desired cookbook and recipe.
    JsonAttributesSources  = "-"
    JsonAttributesContent  = "-"
    ChefClientVersion      = "14"
    ChefClientArguments    = "-"
    WhyRun                 = "False"
    ComplianceSeverity     = "None"
    ComplianceType         = "Custom:Chef"
    ComplianceReportBucket = "-"
    ChefExecutionTimeout   = "3600"
  }
}
}
