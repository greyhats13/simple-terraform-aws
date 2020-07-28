resource "aws_security_group" "kubernetes-server-instance-sg" {
  name        = "kubernetes-server-instance-sg"
  description = "kubectl_instance_sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kubectl_server-SG"
  }
}

resource "aws_instance" "kubernetes-server" {
  count                  = length(var.k8-subnet)
  instance_type          = var.instance_type
  ami                    = var.instance_ami
  key_name               = var.instance_key
  subnet_id              = element(var.k8-subnet, count.index)
  vpc_security_group_ids = [aws_security_group.kubernetes-server-instance-sg.id]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = "20"
    delete_on_termination = "true"
  }

  tags = {
    Name = var.server-name
  }
}
