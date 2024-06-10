variable "domain_name" {
  type        = string
  description = "The domain name for the website."
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
}

variable "common_tags" {
  description = "Common tags you want applied to all components."
}

variable "r53_zone_id" {
  type        = string
  description = "The zone id to apply the record to"

}

variable "env" {
  type = string
}

variable "s3_origin_id" {
  type = string

}

variable "certificate_arn" {
  type = string
}
