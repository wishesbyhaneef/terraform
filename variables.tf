variable "bucket_name" {
  description = "bucket name"
  type        = string
}

variable "aws_region" {
  description = "aws region"
  type        = string
}

# variable "role_arn" {
  # description = "role_arn"
  # type        = string
  
# }
variable "glue_scripts" {
  description = "glue jobs scripts location"
  type        = string
}

# variable "enable-glue-datacatalog" {
  # type        = bool
# }

# variable "enable-spark-ui" {
  # type        = bool
# }

# variable "TempDir" {
  # type        = string
# }

variable "Env" {
  type        = string
}

# variable "deployment" {
  # type        = string
# }

# variable "description" {
  # type        = string
# }

# variable "spark-event-logs-path" {
  # type        = string
# }

variable "job" {
  type        = string
}

# variable "workflow" {
  # type        = string
# }

variable "scripts" {
  type        = string
}

variable "properties" {
  type        = string
}

# variable "connections_db" {
  # type        = string
# }

# variable "EMDM_SHARED_ZIP" {
  # type        = string
# }

variable "excluded_glue_job_name_pattern" {
  type        =list(string)     
}
