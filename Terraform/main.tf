#### Terrafrom main ####
terraform {
  required_version = ">= 1.8.0"
}
provider "aws" {
  region = var.aws_region
}
# Data 
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

# VPC node_modules
module "vpc" {
  source = "./modules/vpc"
  
 # Pass variables into the module
  availability_zone = var.availability_zone
  aws_region        = var.aws_region
  my_ip             = var.my_ip

}


# SG SG Module 
module "security_groups" {
  source = "./modules/sgs"

 # Pass variables into the module
  vpc_id = module.vpc.vpc_id
  my_ip  = var.my_ip

}

# EC2 Instances Module 
module "ec2" {
  source = "./modules/ec2"

 # Pass variables into the module
  ami_id             = data.aws_ami.ubuntu.id
  public_subnet_id   = module.vpc.public_subnet_id
  private_subnet_id  = module.vpc.private_subnet_id

  public_sg1_id       = module.security_groups.public_sg1_id
  private_sg2_id     = module.security_groups.private_sg2_id
  private_sg3_id     = module.security_groups.private_sg3_id

  key_pair_name          = "project1_lara" 
  aws_region      = var.aws_region     
  instance_type   = var.instance_type   
}


