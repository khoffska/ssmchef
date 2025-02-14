terraform {
  backend "s3" {
    bucket         = "01terraformstatebucketzxczxc"       # Your S3 bucket name
    key            = "chefec2/state/terraform.tfstate"           # Path within the bucket to store the state file
    region         = "us-east-1"                         # AWS region for the bucket
    encrypt        = true                                # Enable server-side encryption for the state file
    dynamodb_table = "terraform-locks-ec2chef"                   # DynamoDB table for state locking
  }
}
 