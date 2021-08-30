# ECR Repository to all Docker images of mmp-aws-certification-dev-assoc module

provider "aws" {
  region = var.AWS_REGION
  profile = var.AWS_PROFILE
}

/**
 * image_tag_mutability is set to MUTABLE, this is necessary
 * in order to put a latest tag on the most recent image
 */
resource "aws_ecr_repository" "aws-dev-repo" {
  name = var.repository-name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
}


resource "aws_ecr_lifecycle_policy" "main" {
  repository = aws_ecr_repository.aws-dev-repo.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description = "keep last 10 images"
        action = {
          type = "expire"
        }
        selection = {
          tagStatus = "any"
          countType = "imageCountMoreThan"
          countNumber = 10
        }
      }]
  })
}