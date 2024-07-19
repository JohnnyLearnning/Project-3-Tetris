# Creating Load Balancer

# Local variable
locals {
    load_balancer_type = "application"
    common_tags = {
        Name = "fantastic-5-elb"
    }
}



# Load Balancer
resource "aws_lb" "load-balancer" {
  name               = "${var.project}-lb"
  internal           = false
  load_balancer_type = local.load_balancer_type
  security_groups    = [aws_security_group.load-balancer-sg.id]
  subnets            = var.subnet_ids #[aws_subnet.project-2-public-subnet.id, aws_subnet.project-2-public-subnet1.id] [aws_subnet.public[0].id, aws_subnet.public[1].id]
  tags = merge({ "Name" = "${var.project}-lb"}, local.common_tags)
}

# Load Balancer Security Group
resource "aws_security_group" "load-balancer-sg" {
    name        = "${var.project}-lb-sg"
    description = "Security group for Load Balancer"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = merge({ "Name" = "${var.project}-lb-sg" }, local.common_tags)
}

