variable "CIDR" {}
variable "AWS_REGION" {}
variable "AWS_PROFILE" {}
variable "AWS_AVAILABILITY_ZONES" {}
variable "AWS_PROJECT_NAME" {
  description = "the name of your stack, e.g. \"demo\""
}
variable "AWS_ENVIRONMENT" {
  description = "the name of your environment, e.g. \"prod\""
  default     = "dev"
}

variable "AWS_PRIVATE_SUBNETS" {
  description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default = [
    "10.0.0.0/20",
    "10.0.32.0/20",
    "10.0.64.0/20"]
}

variable "AWS_PUBLIC_SUBNETS" {
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
  default = [
    "10.0.16.0/20",
    "10.0.48.0/20",
    "10.0.80.0/20"]
}
