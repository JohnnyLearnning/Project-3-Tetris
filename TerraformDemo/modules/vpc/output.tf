output "vpc_id"{
    value = aws_vpc.main.id
}

output "public_subnet_id"{
    value = aws_subnet.public[0].id
}

output "subnet_ids" {
  value = [aws_subnet.public[0].id, aws_subnet.public[1].id]
}