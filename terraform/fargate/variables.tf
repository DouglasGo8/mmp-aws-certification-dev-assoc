variable "AWS_REGION" {}
variable "AWS_PROFILE" {}
//
variable "AWS_VPC_ID" {}

variable "AWS_DB_HOST" {}

variable "AWS_CPU_MiB_SIZE" {}
variable "AWS_MEMORY_MiB_SIZE" {}
//
variable "AWS_ECR_IMAGE_URI" {}
variable "AWS_NETWORK_MODE" {}
variable "AWS_CONTAINER_NAME" {}
variable "AWS_CONTAINER_PORT_NUMBER" {}

variable "AWS_ECS_CPU_LOW_THRESHOLD_PER" {
  default = 20
}

# The minimum number of containers that should be running.
# Must be at least 1.
# used by both autoscale-by-perf.tf and autoscale-by-time.tf
# For production, consider using at least "3".
variable "AWS_CONTAINERS_MIN_REPLICAS" {}

variable "AWS_CONTAINERS_MAX_REPLICAS" {}

//
variable "AWS_PROJECT_NAME" {
  description = "the name of your stack, e.g. \"demo\""
}

variable "AWS_ENVIRONMENT" {
  description = "the name of your environment, e.g. \"prod\""
  default     = "dev"
}

variable "AWS_LB_PORT" {
  default = "80"
}

variable "AWS_LB_PROTOCOL" {
  default = "HTTP"
}

variable "AWS_AMI_OWNERS" {
  type    = list(string)
  default = ["099720109477"]
  # Canonical
}

variable "AWS_LB_HEALTH_CHECK_PATH" {
  default = "/q/health/"
}

variable "logs_retention_in_days" {
  type        = number
  default     = 1
  description = "Specifies the number of days you want to retain log events"
}

