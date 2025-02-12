resource "aws_ssm_association" "chef_association" {
  name = "AWS-ApplyChefRecipes"

  targets {
    key    = "InstanceIds"
    values = [var.instance_id]
  }

  parameters = {
    SourceType             = "GitHub"
    # Ensure the S3 URL is publicly accessible or the instance can access it via appropriate IAM roles. 
    SourceInfo = jsonencode({
      owner      = "sous-chefs",
      repository = "docker",
      path       = "",            // Path within the repo, if needed (empty if at root)
      getOptions = "branch:main"  // Adjust if you want to pull a different branch
    })
    RunList               = "recipe[docker]"  // Change to a wrapper recipe if needed
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
