provider "aws" {
  region     = "${var.aws_region}"
}

resource "aws_key_pair" "ansible" {
  key_name   = "ansible"
  public_key = "${file(var.ansible_public_key_path)}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

}

resource "aws_security_group" "ssh" {
  name        = "ssh"
  description = "Allow ssh inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "outbound_internet" {
  name        = "outbound_internet"
  description = "Allow outbound traffic to the internet"

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
