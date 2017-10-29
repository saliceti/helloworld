resource "aws_security_group" "web" {
  name        = "web"
  description = "Web tier group"

  ingress {
    from_port   = "${var.web_port}"
    to_port     = "${var.web_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.ansible.key_name}"
  security_groups = [
    "${aws_security_group.ssh.name}",
    "${aws_security_group.outbound_internet.name}",
    "${aws_security_group.web.name}"
  ]
  associate_public_ip_address = true
  user_data = "${file("terraform/boot.sh")}"

  tags {
    Name = "web"
    tier = "web"
  }
}
