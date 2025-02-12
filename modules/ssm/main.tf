resource "aws_ssm_association" "chef_association" {
  name = "AWS-ApplyChefRecipes"

  targets {
    key    = "InstanceIds"
    values = [var.instance_id]
  }

  parameters = {
    SourceType             = ["S3"]
    SourceInfo             = [jsonencode({ path = "https://aws-applychefrecipes-examples.s3.amazonaws.com/apply-chef-recipes-example-cookbook.tar.gz" })]
    RunList                = ["recipe[apply-chef-recipes-example-cookbook::default]"]
    JsonAttributesSources  = ["-"]
    JsonAttributesContent  = ["{\"filepath\":\"example.txt\", \"content\":\"Hello, World!\"}"]
    ChefClientVersion      = ["14"]
    ChefClientArguments    = ["-"]
    WhyRun                 = ["False"]
    ComplianceSeverity     = ["None"]
    ComplianceType         = ["Custom:Chef"]
    ComplianceReportBucket = ["-"]
    ChefExecutionTimeout   = ["3600"]
  }
}
