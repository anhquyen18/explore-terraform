provider "aws" {
  region = "ap-southeast-1"
}

terraform {
  cloud {

    organization = "PAI"

    workspaces {
      name = "explore-terraform"
    }
  }
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"] # Lọc kiến trúc x86_64
  }

  owners = ["099720109477"]
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ami.id
  instance_type = "t3.micro"

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Server"
  }
}

output "public_ip" {
  value = aws_instance.server.public_ip
}
