variable "vpc_id" {
  description = "ID of the VPC"
}

variable "http_port" {
  description = "Port for HTTP traffic"
  default     = 80
}

variable "ssh_port" {
  description = "Port for SSH traffic"
  default     = 22
}

variable "cidr_blocks" {
  description = "CIDR blocks to allow traffic from"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
