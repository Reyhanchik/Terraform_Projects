variable "AWS_ACCESS_KEY" {}

variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "token" { type = string }

variable "VPC_CIDR_BLOCK" {}

variable "SUBNET_CIDR_BLOCK" {}

variable "INGRESS1" {}

variable "INGRESS2" {}

variable "RT_CIDR_BLOCK" {}

variable "AMI" {}

variable "INSTANCE_TYPE" {
  type = map(string)
}

# variable "INSTANCE_NAME" {
#   type = list(string)
# }



   