#### Terraform Outputs ####

# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = module.vpc.private_subnet_id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.igw_id
}

output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = module.vpc.nat_gateway_id
}

output "nat_gateway_eip" {
  description = "The Elastic IP of the NAT Gateway"
  value       = module.vpc.nat_eip
}

# Security Group Outputs
output "public_sg1_id" {
  description = "Security Group ID for Vote/Result servers (public)"
  value       = module.security_groups.public_sg1_id
}

output "private_sg2_id" {
  description = "Security Group ID for Redis/Worker server (private)"
  value       = module.security_groups.private_sg2_id
}

output "private_sg3_id" {
  description = "Security Group ID for PostgreSQL server (private)"
  value       = module.security_groups.private_sg3_id
}

# EC2 Instance Outputs - Frontend Server
output "frontend_server_id" {
  description = "Frontend server instance ID"
  value       = module.ec2.frontend_instance_id
}

output "frontend_server_public_ip" {
  description = "Frontend server public IP"
  value       = module.ec2.frontend_public_ip
}

output "frontend_server_private_ip" {
  description = "Frontend server private IP"
  value       = module.ec2.frontend_private_ip
}

# EC2 Instance Outputs - Backend Server
output "backend_server_id" {
  description = "Backend server instance ID"
  value       = module.ec2.backend_instance_id
}

output "backend_server_private_ip" {
  description = "Backend server private IP"
  value       = module.ec2.backend_private_ip
}

# EC2 Instance Outputs - Database Server
output "db_server_id" {
  description = "Database server instance ID"
  value       = module.ec2.db_instance_id
}

output "db_server_private_ip" {
  description = "Database server private IP"
  value       = module.ec2.db_private_ip
}

# Application URLs
output "vote_app_url" {
  description = "Vote application URL"
  value       = "http://${module.ec2.frontend_public_ip}:8080"
}

output "result_app_url" {
  description = "Result application URL"
  value       = "http://${module.ec2.frontend_public_ip}:8081"
}

# Environment Variables for Configuration
output "redis_host" {
  description = "Redis host address (for Vote app configuration)"
  value       = module.ec2.backend_private_ip
}

output "postgres_host" {
  description = "PostgreSQL host address (for Worker and Result app configuration)"
  value       = module.ec2.db_private_ip
}