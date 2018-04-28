# CMD: aws ec2 create-vpc --cidr-block 10.0.0.0/16
# Above command will only create a plain VPC without IG and Public Routes.
variable "vpc_id" {
  default = "vpc-9ef687f7" # Using the default vpc.
}
