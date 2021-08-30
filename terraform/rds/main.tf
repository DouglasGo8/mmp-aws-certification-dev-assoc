terraform {
  required_version = "~> 1.0.3"
}

resource "aws_db_instance" "rds-postgres" {
  storage_type = "gp2"
  engine = var.RDS_ENGINE
  username = var.RDS_USERNAME
  password = var.RDS_PASSWORD
  # availability_zone = data.aws_availability_zones.name[0]
  engine_version = var.ENGINE_VERSION
  identifier = "${var.PROJECT_NAME}-database"
  instance_class = var.DB_INSTANCE_CLASS
  allocated_storage = var.RDS_ALLOCATED_STORAGE
  backup_retention_period = var.BACKUP_RETENTION_PERIOD
  name = var.RDS_DB_NAME
  //db_subnet_group_name = aws_db_subnet_group.rds-subnet-group.id
  vpc_security_group_ids = [aws_security_group.rds-postgres-sg.id]
  multi_az = "true"
  publicly_accessible = true
  skip_final_snapshot = true
  tags = {
    Environment = var.PROJECT_NAME
  }
}

resource "aws_db_subnet_group" "rds-subnet-group" {
  name = "${var.PROJECT_NAME}-rds-subnet-group"
  subnet_ids = var.AWS_PUBLIC_SUBNETS
  description = "RDS subnet Group"
  tags = {
    Environment = var.PROJECT_NAME
  }
}

resource "aws_security_group" "db-access-sg" {
  vpc_id = var.VPC_ID
  name = "${var.PROJECT_NAME}-db-access-sg"
  description = "Allowed subnets for Postgres DB cluster instances"

  tags = {
    Name = "${var.PROJECT_NAME}-db-access-sg"
    Environment = var.PROJECT_NAME
  }
}

resource "aws_security_group" "rds-postgres-sg" {
  name = "${var.PROJECT_NAME}-rds-postgres"
  vpc_id = var.VPC_ID
  description = "Postgres Segurity Group"


  ingress {
    // NEEDS
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
  }

  tags = {
    Name = "${var.PROJECT_NAME}-rds-posgtres"
    Environment = var.PROJECT_NAME
  }

}

