variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
}

variable "availability_zone" {
  description = "Availability Zone for the subnet"
}
