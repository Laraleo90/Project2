variable "key_pair_name" {
  type        = string
}
variable "aws_region" {
  type        = string
}

variable "instance_type" {
  type        = string
}

variable "ami_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "private_subnet_id" {
  type = string
}

variable "public_sg1_id" {
  type = string
}

variable "private_sg2_id" {
  type = string
}

variable "private_sg3_id" {
  type = string
}
