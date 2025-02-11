output "ssm_document_name" {
  description = "The name of the SSM document"
  value       = aws_ssm_document.chef_deploy_document.name
}
