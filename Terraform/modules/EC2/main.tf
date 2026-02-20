##### Create the Servers #####

# 1- Application Tier - Frontend - Vote & Result
resource "aws_instance" "frontendserver" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = var.public_subnet_id
  vpc_security_group_ids = [var.public_sg1_id]
  key_name               = var.key_pair_name

  tags = {
    Name = "Frontendserver_lara"
  }
}

# 2- Data/Backend Services - Redis & Worker
resource "aws_instance" "backendserver" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.private_sg2_id]
  key_name               = var.key_pair_name

  tags = {
    Name = "Backendserver_lara"
  }
}

# 3- Database Tier - PostgreSQL
resource "aws_instance" "dbserver" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.private_sg3_id]
  key_name               = var.key_pair_name

  tags = {
    Name = "dbserver_lara"
  }
}
