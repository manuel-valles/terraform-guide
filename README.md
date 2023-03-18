# Terraform Guide

This is an introduction to **Terraform**

> NOTE: This guide steps are based on a MacOS system and AWS

## Installation

- `$ brew install terraform`
- Alternatives: https://developer.hashicorp.com/terraform/downloads
- AWS CLI: https://docs.aws.amazon.com/cli/latest/reference/

## Cloud Access

Once you have your user (e.g. `terraform-user`) and user group (e.g. `terraform-course`) in AWS:

- `$ aws configure` will request _key_, _secret_, _region_ and _format_. This will create a folder `~/.aws` with the corresponding files `config` and `credentials`

> NOTE: You can create an _access key_ under _security credentials_ (`key` and `secret`)

## Create AWS Instance with IaC

An example of hands on can be found in [overview](./01-overview/main.tf)
All the options for `aws_instance` are available in the terraform registry for [aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)

> NOTE: For the `ami` value, you should be able to check your ec2 available for the specific region, e.g. `eu-west-2`: https://eu-west-2.console.aws.amazon.com/ec2/home?region=eu-west-2#LaunchInstances:

Steps:

- `$ terraform init` initializes your project with any providers you've set in the `tf` file
- `$ terraform plan` prompts the changes
- `$ terraform apply` applies the plan/changes. Then type `yes` and enter. You can go to the GUI and check that the instance has been actually created
- `$ terraform destroy` shuts down and terminates all ☢️
