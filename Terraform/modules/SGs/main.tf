##### Create security groups #####

#1
resource "aws_security_group" "sg1" {
  name        = "Vote/ResultSG_lara"
  description = "Allow incoming HTTP/HTTPS from internet"
  vpc_id      = var.vpc_id

  # Allow Vote app (port 8080) from anywhere
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Vote application - public access"
  }

  # Allow Result app (port 8081) from anywhere
  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Result application - public access"
  }

  # Allow SSH ONLY from your IP
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
    description = "SSH access - restricted to my IP"
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name = "sg1-Vote-Result-lara"
  }
}

#2

resource "aws_security_group" "sg2" {
  name        = "Redis/WorkerSG_lara"
  description = "Allows inbound traffic from Vote/Result EC2 to Redis port (6379), and allows outbound to Postgres"
  vpc_id      = var.vpc_id

  # Allow Redis access only from web apps security group
  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    description     = "Redis access from web apps"
    security_groups = [aws_security_group.sg1.id] 
  }

  # SSH for management
  ingress {
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  description     = "SSH from frontend (bastion)"
  security_groups = [aws_security_group.sg1.id]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg2-Redis-Worker-lara"
  }
}

#3

resource "aws_security_group" "sg3" {
  name        = "PostgresSG_lara"
  description = "Security group for PostgreSQL"
  vpc_id      = var.vpc_id

  # Allow PostgreSQL access only from web apps
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    description     = "PostgreSQL access from web apps"
    security_groups = [aws_security_group.sg2.id, aws_security_group.sg1.id]  
  }

  # SSH
  ingress {
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  description     = "SSH from frontend (bastion)"
  security_groups = [aws_security_group.sg1.id]
}
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg3-Postgres-lara"
  }
}