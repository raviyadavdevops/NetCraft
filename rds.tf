resource "aws_db_instance" "main" {
  identifier             = "main-rds-db"
  allocated_storage      = 20
  engine                 = "mysql"
  instance_class         = "db.t3.micro"
  name                   = "mydb"
  username               = "admin"
  password               = "password" # Use a secret manager in production
  multi_az               = true
  skip_final_snapshot    = true
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  tags = {
    Name = "main-rds-db"
  }
}

resource "aws_db_subnet_group" "main" {
  name       = "main-subnet-group"
  subnet_ids = [aws_subnet.private_1a.id, aws_subnet.private_1b.id]

  tags = {
    Name = "main-subnet-group"
  }
}
