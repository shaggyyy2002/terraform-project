# Terraform Beginner Bootcamp 2023 - Week 1

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