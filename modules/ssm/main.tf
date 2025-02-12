resource "aws_ssm_association" "chef_association" {
  name = "AWS-ApplyChefRecipes"

  targets {
    key    = "InstanceIds"
    values = [var.instance_id]
  }

  parameters = {
    SourceType             = "GitHub"
    SourceInfo             = jsonencode({
                               owner      = "dev-sec",
                               repository = "chef-os-hardening",
                               path       = "",         # Set to a subdirectory if needed
                               getOptions = "branch:master"
                             })
    RunList                = "recipe[os-hardening::default]"
    JsonAttributesSources  = "-"
    JsonAttributesContent  = "{\"filepath\":\"example.txt\", \"content\":\"Hello, World!\"}"
    ChefClientVersion      = "14"
    ChefClientArguments    = "-"
    WhyRun                 = "False"
    ComplianceSeverity     = "None"
    ComplianceType         = "Custom:Chef"
    ComplianceReportBucket = "-"
    ChefExecutionTimeout   = "3600"
  }
}
