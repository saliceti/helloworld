resource "aws_security_group" "app" {
  name        = "app"
  description = "App tier"

  ingress {
    from_port   = "${var.app_port}"
    to_port     = "${var.app_port}"
    protocol    = "tcp"
    security_groups = ["${aws_security_group.web.id}"]
  }

}

resource "aws_instance" "app" {
  count         = "${var.app_instance_count}"
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.ansible.key_name}"
  security_groups = [
    "${aws_security_group.ssh.name}",
    "${aws_security_group.outbound_internet.name}",
    "${aws_security_group.app.name}"
  ]
  associate_public_ip_address = true
  user_data = "${file("terraform/boot.sh")}"

  tags {
    Name = "app-${count.index}"
    tier = "app"
  }
}
