resource "aws_db_instance" "default" {
    allocated_storage = var.allocated_storage
    storage_type = var.storage_type
    engine = var.engine
    engine_version = var.engine_version
    instance_class = var.instance_class
    identifier = var.db_identifier
    username = var.username
    password = var.password
    parameter_group_name = var.parameter_group_name
    skip_final_snapshot = true

    db_subnet_group_name    = aws_db_subnet_group.default.name

    vpc_security_group_ids  = [var.db_sg_id]

    tags = {
      Name = "Pract-DB"
    }
}

resource "aws_db_subnet_group" "default" {
  name       = "${var.proApp_project}-db-subnet-group"
  subnet_ids = var.db_subnet_ids  # pass this in from your VPC module

  tags = {
    Name = "${var.proApp_project}-db-subnet-group"
  }
}
