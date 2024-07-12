#########################################################################################################
## Configure the AWS Provider
#########################################################################################################
provider "aws" {
#  access_key = var.aws_access_key
#  secret_key = var.aws_secret_key
#  token      = var.aws_session_token

  profile = var.terraform_aws_profile
  region = var.aws_region
  default_tags {
    tags = {
      managed_by = "terraform"
    }
  }
}