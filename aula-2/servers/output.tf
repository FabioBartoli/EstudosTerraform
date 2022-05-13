output "ip_address" {
  value = aws_instance.web[*].public_ip
}

output "dns_address" {
  value = aws_instance.web[*].public_dns
}