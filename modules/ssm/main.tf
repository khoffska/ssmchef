resource "aws_ssm_document" "chef_deploy_document" {
  name          = var.document_name
  document_type = "Command"
  content       = jsonencode({
    schemaVersion = "2.0",
    description   = "Run Chef client to deploy cookbooks",
    mainSteps     = [{
      action = "aws:runShellScript",
      name   = "runChef",
      inputs = {
        runCommand = var.chef_commands
      }
    }]
  })
}

resource "aws_ssm_association" "chef_deploy_association" {
  name        = aws_ssm_document.chef_deploy_document.name
  targets {
    key    = "InstanceIds"
    values = [var.instance_id]
  }
}
