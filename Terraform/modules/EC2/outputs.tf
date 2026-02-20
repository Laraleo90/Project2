##### EC2 Module Outputs #####

# Frontend Server Outputs
output "frontend_instance_id" {
  description = "Frontend server instance ID"
  value       = aws_instance.frontendserver.id
}

output "frontend_public_ip" {
  description = "Frontend server public IP"
  value       = aws_instance.frontendserver.public_ip
}

output "frontend_private_ip" {
  description = "Frontend server private IP"
  value       = aws_instance.frontendserver.private_ip
}

# Backend Server Outputs
output "backend_instance_id" {
  description = "Backend server instance ID"
  value       = aws_instance.backendserver.id
}

output "backend_private_ip" {
  description = "Backend server private IP"
  value       = aws_instance.backendserver.private_ip
}

# Database Server Outputs
output "db_instance_id" {
  description = "Database server instance ID"
  value       = aws_instance.dbserver.id
}

output "db_private_ip" {
  description = "Database server private IP"
  value       = aws_instance.dbserver.private_ip
}