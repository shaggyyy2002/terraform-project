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