# Please ensure to add 'bucket', 'region' and 'key' in backend.tfvars
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  backend "s3" {
	}
}

# terraform {
# required_version = ">= 0.13.6"
# backend "s3" {
# }
# }


provider "aws" {
  region = var.aws_region
}

locals {

  all_files = fileset("${var.properties}/${var.job}/**/**", "*.yaml")

  #### list out all the glue job names which are not present in var.excluded_glue_job_name_pattern list ####
  filtered_files = [
    for f in local.all_files : f
    if length(
      regexall(join("|", var.excluded_glue_job_name_pattern), f)
    ) == 0
  ]

  glue_job_details = [for f in local.filtered_files : {
    s1              = "${basename(f)}"
    s2              = "${trimsuffix(basename(f), ".yaml")}"
    s3              = "${replace(trimsuffix(basename(f), ".yaml"), "env", var.Env)}"
    glue_job_path = "${dirname(f)}"
    glue_job_path_trimprefix = "${trimprefix(dirname(f), "../../")}"
    glue_properties_path="${var.properties}/${var.job}/${trimprefix(dirname(f),"../../")}/${basename(f)}"
    glue_properties = yamldecode(file("${var.properties}/${var.job}/${trimprefix(dirname(f),"../../")}/${basename(f)}"))  
}]

  # li = [1, 2, 33]
  # test = {
    # for i in local.li : i => "rr"
  # }
}

# output "all_files" {
  # description = "To display all files"
  # value       = local.all_files
# }

# output "filtered_files" {
  # description = "To display filtered_files files"
  # value       = local.filtered_files
# }

# output "glue_job_details" {
  # description = "To display filtered_files files"
  # value       = local.glue_job_details
# }


data "archive_file" "utilzip" {
  type        = "zip"
  source_dir = "./zip_to_s3/"
  output_path = "./zip_to_s3_terraform.zip"
}
resource "aws_s3_object" "upload-utilzip" {
	bucket 		= var.bucket_name
	key 		  =  "/libs/zip_to_s3_terraform.zip"
	source 		= "./zip_to_s3_terraform.zip"
	etag      = filemd5(data.archive_file.utilzip.output_path)
}

# output "upload-utilzip" {
  # description = "To display filtered_files files"
  # value       = data.archive_file.utilzip.output_path
# }
# output "upload-utilzip-md5-hash" {
  # description = "To display filtered_files files"
  # value       = filemd5(data.archive_file.utilzip.output_path)
# }



####### moving glue .py file to the destination s3 bucket using aws_s3_bucket_object #######
resource "aws_s3_object" "upload-glue-script" {
	for_each = fileset("${var.scripts}/**/**", "*py")
	bucket = var.bucket_name
  ####key    = "${var.scripts}/${trimprefix(dirname(each.value),"../../")}/${replace(basename(each.value), "env", var.Env)}"
  key    = "/${var.glue_scripts}/${trimprefix(dirname(each.value),"../../")}/${replace(basename(each.value), "env", var.Env)}"
  source = "${var.scripts}/${trimprefix(dirname(each.value),"../../")}/${basename(each.value)}"
  ####etag makes the file update when it changes
  etag   = filemd5("${var.scripts}/${trimprefix(dirname(each.value),"../../")}/${basename(each.value)}")
}
