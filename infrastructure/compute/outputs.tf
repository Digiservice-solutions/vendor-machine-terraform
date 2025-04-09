output "hello_world_listener_arn" {
  value = aws_lb_listener.hello_world.arn
}

output "private_ec2_private_ip" {
  description = "Private IP Address of the private EC2"
  value       = aws_instance.private_ec2.private_ip
}

output "bastion_public_dns" {
  description = "Public DNS of bastion host"
  value       = aws_instance.bastion.public_dns
}

output "ecs_service_discovery_url" {
  description = "URL to access to ECS service"
  value       = "http://${aws_service_discovery_service.my_service_discovery.name}.${aws_service_discovery_private_dns_namespace.private_dns.name}:3000"
}