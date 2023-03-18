terraform {
  backend "remote" {
    organization = "manu-kem"

    workspaces {
      name = "terraform-course"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region  = "eu-west-2"
}