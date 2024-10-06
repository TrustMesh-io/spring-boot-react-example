variable "env" {
  type        = string
  description = "development"
}

variable "region" {
  type = string
  description = "eu-west-2"
}

variable "cidr" {
  type = string
  description = "10.0.0.0/16"
}

variable "private_subnets" {
  type = list(string)
  description = "[10.0.1.0/24, 10.0.2.0/24, 10.0.3.0/24]"
}

variable "public_subnets" {
  type = list(string)
  description = "[10.0.101.0/24, 10.0.102.0/24, 10.0.103.0/24]"
}