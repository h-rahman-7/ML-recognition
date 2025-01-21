output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.mlops_vpc.id
}

output "public_subnets" {
  description = "The IDs of the public subnets"
  value       = aws_subnet.mlops_public_sn[*].id
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.mlops_igw.id
}