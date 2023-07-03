# AWS-Terraform-Project

# Terraform Example

This repository contains Terraform code for creating AWS resources using modules and resources.

## Importing Resources

To import an existing resource, use the following command:

```
terraform import resource-type.resource-name attribute_or_id
```

Make sure to replace `resource-type.resource-name` and `attribute_or_id` with the specific resource and its attribute or ID.

## Retrieving Modules

To retrieve modules, run the following command:

```
terraform get
```

## IAM User Module

The IAM User module is used to create an IAM user in AWS.

```hcl
module "iam_iam-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "3.4.0"

  name                            = "max"
  create_iam_access_key           = false
  create_iam_user_login_profile   = false
}
```

## AWS Resources

The following AWS resources are defined in the Terraform code:

### IAM User

```hcl
resource "aws_iam_user" "cloud" {
  name  = split(":", var.cloud_users)[count.index]
  count = length(split(":", var.cloud_users))
}
```

### S3 Bucket

```hcl
resource "aws_s3_bucket" "sonic_media" {
  bucket = var.bucket
}
```

### S3 Object

```hcl
resource "aws_s3_object" "upload_sonic_media" {
  bucket = aws_s3_bucket.sonic_media.id
  key    = substr(each.value, 7, 20)
  source = each.value
  for_each = var.media
}
```

### EC2 Instance

```hcl
resource "aws_instance" "mario_servers" {
  ami           = var.ami
  tags = {
    name = var.name
  }
  instance_type = var.name == "tiny" ? var.small : var.large
}
```

