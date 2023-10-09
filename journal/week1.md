# Terraform Beginner Bootcamp 2023 - Week 1

- [Using CLickOPs to setup our distribution](#using-clickops-to-setup-our-distribution)
- [Root module structure](#root-module-structure)
- [Terraform & Varibales](#terraform---varibales)
  * [Terraform Cloud variables](#terraform-cloud-variables)
  * [Loading terraform input variables.](#loading-terraform-input-variables)
  * [var flag](#var-flag)
  * [tfvars-file](#tfvars-file)
- [Dealing with Configuration Drift](#dealing-with-configuration-drift)
  * [What happens if you loose your state file?](#what-happens-if-you-loose-your-state-file-)
  * [Fix missing resources with Terraform import](#fix-missing-resources-with-terraform-import)
  * [Fix Manual Configuration](#fix-manual-configuration)
- [Terraform Modules](#terraform-modules)
  * [terraform module structure](#terraform-module-structure)
  * [Passing Input Varibales](#passing-input-varibales)
  * [Moduules Sources](#moduules-sources)
- [Consideration while using ChatGPT or LLM's.](#consideration-while-using-chatgpt-or-llm-s)
- [Working with files in Terraform](#working-with-files-in-terraform)
  * [File exists function](#file-exists-function)
  * [FileMD](#filemd)
  * [Path Variable](#path-variable)
- [Terraform Locals](#terraform-locals)
- [Terraform Data Sources](#terraform-data-sources)
- [Working with JSON](#working-with-json)
  * [Changing the lifecycle of resources](#changing-the-lifecycle-of-resources)
  * [Terraform Data](#terraform-data)
- [Provisoners](#provisoners)
  * [Local-exec](#local-exec)
  * [Remote-exec](#remote-exec)
- [For Each expression](#for-each-expressions)

## Using CLickOPs to setup our distribution

- During the live stream we created an S3 bucket where our static pages will be stored. 
- To upload it we can either use the CLI or we can drag & drop, since we want make our life a little tough and face issues we used the cli. 
- Firstly we checked what all S3 buckets we are currently running by `aws s3 ls` which will list all our buckets. [AWS CLI Commands](https://docs.aws.amazon.com/cli/latest/reference/s3/)
- Copy the bucket name we want to copy our file to. Then on our cli use `aws s3 /path/to/file cp s3://<bucket-name>/file-name`, this will copy our file from our repo to the s3 bucket. Since our bucket is private it will show `403 Forbidden`
- There are 2 ways of getting it available on internet. 
    - Allow public access to the bucket (donot use it for production)
    - Create a CloudFront distribution. Since we are trying to learn how to do it in an organization and on production we created a cloud front distribution.     
- More about [Cloudfront](https://us-east-1.console.aws.amazon.com/cloudfront/v4/home?region=ap-south-1#/distributions)
- Once the cloudfront has created the districbution, change the S3 bucket policy and click on the distribution link that was prompted and now you would be able to access the index.html.

## Root module structure

Our root module struture is as follows: 
```
PROJECT_ROOT
│
├── main.tf               # everything else.
├── variables.tf          # stores the structure of input variables
├── terraform.tfvars      # the data of variables we want to load into our terraform project
├── providers.tf          # defined required providers and their configuration
├── outputs.tf            # stores our outputs
└── README.md             # required for root modules
```
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)


## Terraform & Varibales

[Variables Docs](https://developer.hashicorp.com/terraform/language/values/variables)

### Terraform Cloud variables

In terraform we can set two kinds of varibales:
- terraform variable: usually set up on terraform.tfvars file. 
- environment varibale: variables which are set on bash terminal. eg. AWS_CREDENTIALS 
We can set environment varibale as sensetive so that its not visibly shown in the UI.

### Loading terraform input variables. 

### var flag
We can use the `-var` flag to set an input varibale or override the input in the `.tfvars` 

### tfvars-file

Tfvars files allow us to manage variable assignments systematically in a file with the extension .tfvars or .tfvars.json. Despite the fact that there are numerous ways to manage variables in Terraform, tfvars files are the best and most common way to do so due to their simplicity and effectiveness.
eg. earlier to setup our `user_uuid="_"` we used the `-var` flag on a command to set it up which could be hectic. So instead we just mentions it on our `.tfvars file`(its hidden so it wont get committed to your VCS)

## Dealing with Configuration Drift

### What happens if you loose your state file?
If you loose your state file you will have to ter down all your cloud infrastructure mannualy. You can use  `terraform import` but it wont work for all cloud resources. You will have to check which resources supports import.    

### Fix missing resources with Terraform import

`terrform import aws_s3_bucket.bucket bucket-name`

[Terraform import](https://developer.hashicorp.com/terraform/language/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies one of our resources using ClickOps by running `terraform plan` we can acheive the desired state or the earlier state. 

## Terraform Modules

### terraform module structure
It is recommended to store modules in a `modules` directory when locally developping modules.  

### Passing Input Varibales
We can pass input varibales from our module.
The module has to declare the terraform varibale in its own variables.tf 
```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Moduules Sources 

Using the source we can import the module from various places eg. locally, github or terraform registry
```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}

```

[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

## Consideration while using ChatGPT or LLM's. 

LLM's may not be trained with the latest terraform modules which are now currently depricated. So its better to look into documentation. 

## Working with files in Terraform

### File exists function

This is a built in terraform function to check the existance of the file.
[File exists Function](https://developer.hashicorp.com/terraform/language/functions/fileexists)
```hcl
condition     = can(file(var.index_html_filepath))
```
### FileMD
[Filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable
In terraform there is a special varibale `path` that allows us to reference local paths:
- path.module = get the path for current module.
- path.root = get the path to the root of the modules.
[Special Path Reference & Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

> If you changed something in the file and used `terrafor apply` it will not detect any change because it works with files and doesnt check our data. To check if its updated you can add an etag to it so that whenever the content changes the etag changes.

```hcl
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${root.dir}/path/to/index.html"
}
```

## Terraform Locals

A local value assigns a name to an expression, so you can use the name multiple times within a module instead of repeating the expression.
```tf
locals {
  service_name = "forum"
  owner        = "Community Team"
}
```
[Terraform Locals](https://developer.hashicorp.com/terraform/language/values/locals)


## Terraform Data Sources
This allows to source data from cloud resources. 

This is useful when we want to refrence cloud data without importing it.

```tf
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

We use the json encode to create the json ploicy inline in the HCL.
```tf
jsonencode({"hello"="world"})
{"hello":"world"}
```

[jsonncode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the lifecycle of resources

[Meta Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

### Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. You can use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

[Terraform Data Sources](https://developer.hashicorp.com/terraform/language/resources/terraform-data)


## Provisoners
Provisioners allows you to execute the commands on compute instances eg. AWS CLI commands. 
Not recommended by hashicorp because configuration management tools are better fit, but the functionality exists. 

[Provisoners Syntax](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec
This will execute the commnands on machine running the terraform commands g. plan apply

```tf
  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }

```
### Remote-exec
This will execute the commands on a machine you will target. You will need to provide credentials eg. SHH keys

[Remote Exec Syntax](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)

```tf
provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
```

## For Each expressions

For each allows us to enumerate over complex data types
```sh
[for s in var.list : upper(s)]
```

This is mostly useful when youre creating multiples of cloud resource and 
you want to reduce the amount of terraform code. 
[For Each Expression](https://developer.hashicorp.com/terraform/language/expressions/for)