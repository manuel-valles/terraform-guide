# Terraform Guide

This is an introduction to **Terraform** (_TF_)

> NOTE: This guide steps are based on a MacOS system and AWS

## 0. Installation

- `$ brew install terraform`
- Alternatives: https://developer.hashicorp.com/terraform/downloads
- AWS CLI: https://docs.aws.amazon.com/cli/latest/reference/

## 1. Overview & Setup

### 1.1. Cloud Access

- Create a non-root user (e.g. `terraform-user`) under a group (e.g. `terraform-course`) in _AWS Console_
- Configure AWS access locally:
  - `$ aws configure` generates a folder `~/.aws` with the corresponding files `config` and `credentials` provided in the prompt step:
    - _key_
    - _secret_
    - _region_
    - _format_

> NOTE: You can create an _access key_ under _security credentials_ (`key` and `secret`) in the GUI.

### 1.2. Create AWS Instance with IaC

- An example of the `main.tf` to create an EC2 by TF can be found in [overview](./01-overview/main.tf):

  - All the options for `aws_instance` are available in the _TF Registry_ for [aws](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)
  - For the `ami` value, you should be able to check your ec2 available for the specific region, e.g. `eu-west-2`: https://eu-west-2.console.aws.amazon.com/ec2/home?region=eu-west-2#LaunchInstances:

TF Steps:

- `$ terraform init` initializes your project with any providers you've set in the `tf` file
- `$ terraform plan` prompts the changes
- `$ terraform apply` applies the plan/changes. Then type `yes` and enter. You can go to the GUI and check that the instance has been actually created
- `$ terraform destroy` shuts down and terminates all ☢️

## 2. Remote Backend

_Remote backends_ enable storage of TF state in a remote location to enable secure collaboration.

You could also set up all in _AWS_ (_S3_ and _DynamoDB_) but for simplicity you can use [TF Cloud](https://app.terraform.io/)

- Once you have created a TF free account, you will need to create the organization and the workspace
- Update the [main](02-remote-backend/terraform-cloud/main.tf) accordingly.
- Final steps:
  - `$ terraform login` prompts TF login with a temporary token (copy and paste in the terminal)
  - `$ terraform init` configures the backend "remote". So TF will automatically use this
  - `$ terraform plan` check changes. This will only show the run process in the remote
  - `$ terraform apply` applies the plan in the remote and provides the run URL
