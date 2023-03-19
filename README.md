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

An example of a _web app_ can be found [here](02-remote-backend/web_app/mainf.tf). You can check all the created resources on the corresponding region on the GUI, and try the balancer with the DNS name shown in the details section, e.g. http://tf-guide-web-app-lb-230187502.eu-west-2.elb.amazonaws.com/

> NOTE: It looks like the latest terraform version has currently a bug where you cannot use the credentials in your local, e.g. `~/.aws`. So you will need to hard code it or create cloud variables set: https://developer.hashicorp.com/terraform/tutorials/cloud-get-started/cloud-create-variable-set.
> <br>Related docs: https://registry.terraform.io/providers/hashicorp/aws/latest/docs

## 2. Variables

## 2.1. Types & Validation

Type checking happens automatically, and custom conditions can also be enforced. The **types** are:

- Primitive:
  - _string_
  - _number_
  - _bool_
- Complex:
  - _list(`<Type>`)_
  - _set(`<Type>`)_
  - _map(`<Type>`)_
  - _object({ `<Attr name>` = `<Type>`, ... })_
  - _tuple([`<Type>`, ...])_

An example of variable block would be:

```tf
variable "var_name" {
  type = string
}
```

Regarding **sensitive data**, you can:

- Mark variable as sensitive with `sensitive = true`
- Pass to TF apply with `TF_VAR_<name>` or retrieve them from secret manager at runtime with `-var`, e.g. `terraform apply -var="db_user=manukem" -var="db_pass=super_secure-one"`
- Use external secret store, e.g. `AWS Secrets Manager`

> NOTE: TF will pick the variables located in `variables.tf` or `<name>.auto.tfvars`. So if you want to specified any other file you will need to do add the flag `-var-file=`, e.g. `$ terraform apply -var-file=another-filename.tfvars`.
> <br> However, this doesn't work with remote backend. So will need to add it to the `tfvars` and remove it or add some dummy data before any push to any remote git.

**Local variables** allow to store the value of an expression for reuse but not for passing in values:

```tf
locals {
  extra_tag = "extra-tag"
}
```

You can also **output** some value, which might not be known ahead of time, like the IP address of a new VM. This will be output after `terraform apply` or `terraform output`. For example, [this](03-variables/example/outputs.tf) will output something like:

```sh
db_instance_addr = "terraform-20230319125949854300000001.cl7bhry90jzi.eu-west-2.rds.amazonaws.com"
instance_ip_addr = "172.31.34.146"
```
