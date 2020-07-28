variable "vpc_id" {
  description = "VPC ID for node"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_ami" {
  default = "ami-0d6bbb3973f07760c" # AMI of Singapore Region
}

variable "nodes_subnet" {
  type = list(string)
}

variable "server_name" {
  default = "Nodes workload"
}
