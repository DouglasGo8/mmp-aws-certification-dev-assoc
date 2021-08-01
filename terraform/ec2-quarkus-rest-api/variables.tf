variable "AWS_REGION" {
  default = "sa-east-1"
}

variable "AWS_PROFILE" {
  default = "default"
}

variable "PUB_SUBNET_1" {
  type    = string
  default = "subnet-0c9cad591980aaf7e"
}

variable "SG_WEB_API" {
  type    = string
  default = "sg-02d77b80f5eed704b"
}

variable "SG_SSH" {
  type    = string
  default = "sg-029400cd17d53fc3f"
}

variable "AMI_OWNERS" {
  type    = list(string)
  default = ["099720109477"]
}
