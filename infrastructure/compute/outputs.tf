

output "hello_world_listener_arn" {
  value = aws_lb_listener.hello_world.arn
}

# Output per l'indirizzo IP privato dell'istanza EC2 privata
output "private_ec2_private_ip" {
  description = "Indirizzo IP privato dell'istanza EC2 privata"
  value       = aws_instance.private_ec2.private_ip
}

# Output per il DNS pubblico del bastion host
output "bastion_public_dns" {
  description = "DNS pubblico del bastion host"
  value       = aws_instance.bastion.public_dns
}

# Output completo con porta per l'accesso al servizio
output "ecs_service_discovery_url" {
  description = "URL completo per accedere al servizio ECS internamente"
  value       = "http://${aws_service_discovery_service.my_service_discovery.name}.${aws_service_discovery_private_dns_namespace.private_dns.name}:3000"
}