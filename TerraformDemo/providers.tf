terraform {

  cloud{
    organization = "jt-skillstorm-cohort"

    workspaces {
      name = "jtrinh-dev" # dev or prod
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}

# Student Used Provider

# provider "aws" {
#   profile = "terraformcloud-demo"
#   default_tags {
#     tags = {
#       env = "dev"
#     }
#   }
# }

# New Provider Block
provider "aws" {
  region = "us-east-1"
  default_tags {
    tags = {
      env = "dev"
    }
  }
}

module "VPC"{
  source = "./modules/vpc"
  availability_zone = data.aws_availability_zones.main.names
}

# module "EC2"{
#   source = "./modules/ec2"
#   vpc_id = module.VPC.vpc_id
#   subnet_id = module.VPC.public_subnet_id
#   instance_ami = data.aws_ssm_parameter.instance_ami.value
# }

module "EKS"{
  source = "./modules/eks"
  public_subnet_ids = module.VPC.subnet_ids

}

module "ELB"{
  source = "./modules/elb"
  vpc_id = module.VPC.vpc_id
  subnet_ids = module.VPC.subnet_ids
  project = "fantastic-5"
}