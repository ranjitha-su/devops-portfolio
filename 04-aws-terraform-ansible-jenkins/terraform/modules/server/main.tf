data "external" "my_ip" {
  program = ["bash", "${path.module}/get_ip.sh"]
}

locals {
  my_ip_cidr = "${data.external.my_ip.result.ip}/32"
}

resource "aws_security_group" "jenkins_security_group" {
  name   = "jenkins-security_group"
  vpc_id = var.vpc_id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = [local.my_ip_cidr]
  }
  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name: "${var.env}_security_group"
  }
}

resource "aws_key_pair" "jenkins_ssh_key" {
  key_name   = "jenkins-ssh-key"
  public_key = file(var.ssh_key_path)
}

resource "aws_instance" "jenkins_ec2_instance" {
  ami           = data.aws_ami.ubuntu_x86_64.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [aws_security_group.jenkins_security_group.id]
  availability_zone = var.az
  key_name = aws_key_pair.jenkins_ssh_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.env}_ec2_instance"
    Env = var.env
    Role = "jenkins"
  }
}
