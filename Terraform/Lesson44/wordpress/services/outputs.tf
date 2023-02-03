output "efs_address" {
  value = aws_efs_file_system.efs.dns_name
}

output "rds_address" {
  value = aws_db_instance.default.address
}