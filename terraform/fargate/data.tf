data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  # Canonical
  owners = var.AWS_AMI_OWNERS

}

data "template_file" "app_task" {
  template = file("${path.module}/tasks/app_task_definition.json")
  vars = {
    aws_region = var.AWS_REGION
    aws_db_host = ""
    container_name = var.AWS_CONTAINER_NAME
    container_image = var.AWS_ECR_IMAGE_URI
    container_port = var.AWS_CONTAINER_PORT_NUMBER
    container_memory = var.AWS_MEMORY_MiB_SIZE
  }
}