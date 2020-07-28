variable "ssh_public_key" {
  default = ""
}

variable "vpc_id" {
  default = ""
}

variable "instance_type" {
  description = "instance type for K8s creation Server - Eg:m5.large"
}

variable "instance_ami" {
  description = "AMI for Instance"
}

variable "instance_key" {
  description = "Key for k8s Server"
}

variable "server-name" {}

variable "k8-subnet" {
  type = list(string)
}

variable "allocation_id" {
  type  = string
}

variable "nodes_subnet" {
  type  = list(string)
}
