resource "aws_rds_cluster" "aurora_cluster" {
  cluster_identifier     = "deluxe-ec2-aurora-postgresql-cluster" 
  engine                = "aurora-postgresql"
  engine_version        = "16.6"  
  database_name         = var.db_name
  master_username       = var.db_username
  master_password       = var.db_password
  skip_final_snapshot   = true
  
  vpc_security_group_ids = [aws_security_group.aurora_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.aurora_subnet_group.name

  backup_retention_period = 7
  preferred_backup_window = "02:00-03:00"
}

# Create Aurora instances
resource "aws_rds_cluster_instance" "aurora_instances" {
  count               = 2  # One writer, one reader
  identifier          = "deluxe-ec2-my-aurora-instance-${count.index}"
  cluster_identifier  = aws_rds_cluster.aurora_cluster.id
  instance_class      = "db.t3.medium"
  engine              = aws_rds_cluster.aurora_cluster.engine
  engine_version      = aws_rds_cluster.aurora_cluster.engine_version
}

# Create DB subnet group
resource "aws_db_subnet_group" "aurora_subnet_group" {
  name       = "deluxe-ec2-aurora-subnet-group"
  subnet_ids = var.public_subnets
}

# Create security group for Aurora
resource "aws_security_group" "aurora_sg" {
  name        = "${var.name}-aurora-security-group"
  description = "Security group for Aurora cluster"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 5432  
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.vectre_instance_sg] 
  }
}

