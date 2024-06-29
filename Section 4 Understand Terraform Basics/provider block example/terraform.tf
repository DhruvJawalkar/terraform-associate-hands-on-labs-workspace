/*
# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}
*/
/*
provider "aws" {
  region     = "us-east-1"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
*/

/*
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "/Users/sample_user/.aws/creds"
  profile                 = "default"
}
*/
provider "aws" {
  region     = "us-west-2"
}