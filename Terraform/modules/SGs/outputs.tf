output "public_sg1_id" {
  description = "Security Group ID for Vote/Result servers"
  value       = aws_security_group.sg1.id
}

output "private_sg2_id" {
  description = "Security Group ID for Redis/Worker server"
  value       = aws_security_group.sg2.id
}

output "private_sg3_id" {
  description = "Security Group ID for PostgreSQL server"
  value       = aws_security_group.sg3.id
}