resource "aws_ssm_association" "chef_association" {
  name = "AWS-ApplyChefRecipes"

  targets {
    key    = "InstanceIds"
    values = [var.instance_id]
  }

  parameters = {
    SourceType = "S3"
    SourceInfo = "{\"path\": \"https://chefcookbooks9999.s3.amazonaws.com/dockerwrapper2.tar.gz\"}"
    RunList                = "recipe[docker_wrapper2::default]"
    JsonAttributesSources  = "-"
    JsonAttributesContent  = "-"
    ChefClientVersion      = "16"
    ChefClientArguments    = "-"
    WhyRun                 = "False"
    ComplianceSeverity     = "None"
    ComplianceType         = "Custom:Chef"
    ComplianceReportBucket = "-"
    ChefExecutionTimeout   = "3600"
  }
}
 