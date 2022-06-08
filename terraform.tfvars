AWS_ACCESS_KEY    = "AKIAY645SDXG65CVD7WJ"
AWS_SECRET_KEY    = "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"
token             = "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"
VPC_CIDR_BLOCK    = "172.0.0.0/16"
SUBNET_CIDR_BLOCK = "172.0.1.0/24"
INGRESS1          = "22"
INGRESS2          = "8080"
RT_CIDR_BLOCK     = "10.0.2.0/32"
AMI               = "ami-0f095f89ae15be883"
INSTANCE_TYPE = {
  "jenkins"    = "t2.micro"
  "kubernetes" = "t2.small"
}
# INSTANCE_NAME = {
#   "user1" = "jenkins"
#   "user2" = "kubernetes"
#   "user3" = "ansible" }