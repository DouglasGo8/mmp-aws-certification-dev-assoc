variable "AWS_REGION" {
  default = "sa-east-1"
}

variable "AWS_PROFILE" {
  default = "default"
}

variable "AWS_PUBLIC_SUBNETS" {
  default = [
    "subnet-02c6b91feb4049525",
    "subnet-042922c39a8cf0d7f",
    "subnet-04c878ee3f9e1d8ff"
  ]
  type = list
  description = "Public Subnets"
}

# Project wide variable
variable PROJECT_NAME {}

# RDS Variables
variable "VPC_ID" {}
variable "RDS_ENGINE" {}
variable "DB_INSTANCE_CLASS" {}
variable "ENGINE_VERSION" {}
variable "BACKUP_RETENTION_PERIOD" {}
variable "PUBLICLY_ACCESSIBLE" {}
variable "RDS_DB_NAME" {}
variable "RDS_USERNAME" {}
variable "RDS_PASSWORD" {}
variable "RDS_ALLOCATED_STORAGE" {}
variable "RDS_CIDR" {}