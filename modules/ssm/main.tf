resource "aws_ssm_association" "chef_association" {
  name = "AWS-ApplyChefRecipes"

  targets {
    key    = "InstanceIds"
    values = [var.instance_id]
  }

  parameters = {
    SourceType             = "GitHub"
    SourceInfo = jsonencode({
      owner      = "khoffska",
      repository = "ssmchef",
      path       = "",            
      getOptions = "branch:main"  
    })
    RunList               = "recipe[docker_wrapper::default]"  // Change to a wrapper recipe if needed
    JsonAttributesSources = "-"
    JsonAttributesContent = "-"
    ChefClientVersion     = "14"
    ChefClientArguments   = "-"
    WhyRun                = "False"
    ComplianceSeverity    = "None"
    ComplianceType        = "Custom:Chef"
    ComplianceReportBucket= "-"
    ChefExecutionTimeout  = "3600"
  }
}
