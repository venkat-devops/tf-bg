variable "app_ver" {
  default = "2"
}

variable "key_pair" {
  default = "myawskey"
}

variable "domain" {
  default = "yourdoamin"
}

variable "aws_region" {
  description = "Region for the VPC"
  default     = "eu-west-2"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default     = "10.0.0.0/16"
}
