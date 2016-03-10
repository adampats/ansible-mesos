variable "key" {
  default = "adamkeys"
}

provider "aws" {
    region = "us-west-2"
}

resource "aws_security_group" "allow_ssh_mesos" {
  name = "allow_ssh_mesos"
  description = "Allow SSH inbound traffic"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 8
      to_port = 0
      protocol = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 2181
    to_port = 2181
    protocol = "tcp"
    self = true
  }
  ingress {
    from_port = 2888
    to_port = 2888
    protocol = "tcp"
    self = true
  }
  ingress {
    from_port = 3888
    to_port = 3888
    protocol = "tcp"
    self = true
  }
  ingress {
    from_port = 5050
    to_port = 5050
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "allow_ssh_mesos"
  }
}

resource "aws_spot_instance_request" "server" {
  count = 3
  spot_price = "0.02"
  instance_type = "m3.large"

  ami = "ami-f7a2bf96"
  tags {
    Name = "App"
  }
  key_name = "${var.key}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh_mesos.id}"]
}
