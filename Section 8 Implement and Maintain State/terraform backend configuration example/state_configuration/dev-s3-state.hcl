    bucket = "my-terraform-state-djawalkar"
    key    = "dev/aws_infra"
    region = "us-east-1"

    dynamodb_table = "terraform-locks"
    encrypt        = true