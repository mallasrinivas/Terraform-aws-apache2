module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = "11.0.0.0/16"
}
module "subnet1" {
  source            = "./modules/subnet"
  vpc_id            = module.vpc.vpc_id
  subnet_cidr_block = "11.0.1.0/24"
  availability_zone = "ap-south-1a"
}
module "subnet2" {
  source            = "./modules/subnet"
  vpc_id            = module.vpc.vpc_id
  subnet_cidr_block = "11.0.2.0/24"
  availability_zone = "ap-south-1b"
}
module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
}


module "ec2_instance1" {
  source            = "./modules/ec2_instance"
  ami_id            = var.ami_id # Ubuntu AMI, Update with your desired AMI
  instance_type     = var.instance_type
  subnet_id         = module.subnet1.subnet_id
  security_group_id = module.security_group.security_group_id
}

module "ec2_instance2" {
  source            = "./modules/ec2_instance"
  ami_id            = var.ami_id # Ubuntu AMI, Update with your desired AMI
  instance_type     = var.instance_type
  subnet_id         = module.subnet2.subnet_id
  security_group_id = module.security_group.security_group_id
}

resource "aws_route_table" "dev_proj_1_public_route_table" {
  vpc_id = module.vpc.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.internet_gateway.internet_gateway_id
  }
  tags = {
    Name = "dev-proj-1-public-rt"
  }
}

# resource "aws_network_interface" "instance_nic" {
#   subnet_id   = module.subnet2.subnet_id
#   private_ips = ["11.0.2.10"] # Example, update with desired private IP address
# }

# resource "aws_network_interface_attachment" "instance_nic_attachment" {
#   instance_id          = module.ec2_instance2.instance_id
#   network_interface_id = aws_network_interface.instance_nic.id
#   device_index         = 0
# }