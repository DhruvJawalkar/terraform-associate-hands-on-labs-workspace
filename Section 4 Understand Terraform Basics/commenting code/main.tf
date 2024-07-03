# begins a single-line comment, ending at the end of the line.
// also begins a single-line comment, as an alternative to #.
/* and */ are start and end delimiters for a comment that might span over multiple lines.

# IaC Buildout for Terraform Associate Exam

# Configure the AWS Provider
/*
Name: IaC Buildout for Terraform Associate Exam
Description: AWS Infrastructure Buildout
Contributors: Bryan and Gabe
*/
provider "aws" {
  region = "us-east-1"
}

