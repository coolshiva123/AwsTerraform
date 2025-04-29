terraform {
  required_version = "~>1.11.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.96.0"
    }
  }
   backend "s3" {  
    bucket       = "arg0-s3-bucket-01"  
    key          = "argosetup/statefile.tfstate"  
    region       = "us-east-1"  
    dynamodb_table = "arg0-dynamo-table-01"
    encrypt      = true  
  } 
}

provider "aws" {
  region = var.region_var
}