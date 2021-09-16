variable "AWS_REGION" {
  default = "sa-east-1"
}

variable "AWS_PROFILE" {
  default = "default"
}

variable "AMI_OWNERS" {
  type    = list(string)
  default = ["099720109477"] # Canonical
}
variable "EC2_INST_USER_NAME" {
  default = "ubuntu"
}

variable "VPC_ID" {}
variable "AMZ_SUBNETS" {}
variable "PROJECT_NAME" {}
variable "AMZ_INSTANCE_TYPE" {}

