
# terraform import resource-type.resource-name attribute or id -- create blank resource file
# terraform get
module "iam_iam-user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "3.4.0"
  # insert the 1 required variable here
        name = "max"
        create_iam_access_key = false
        create_iam_user_login_profile = false
}

# terraform console
resource "aws_iam_user" "cloud" {
     name = split(":",var.cloud_users)[count.index]
     count = length(split(":",var.cloud_users))

}
resource "aws_s3_bucket" "sonic_media" {
     bucket = var.bucket

}
resource "aws_s3_object" "upload_sonic_media" {
     bucket = aws_s3_bucket.sonic_media.id
     key =  substr(each.value, 7, 20)
     source = each.value
     for_each = var.media

}

resource "aws_instance" "mario_servers" {
        ami = var.ami
        tags = {
                name = var.name
}
        instance_type = var.name == "tiny" ? var.small : var.large
}
