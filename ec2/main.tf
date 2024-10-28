provider "aws" {
  region = "ap-southeast-1"
}

# data "aws_ami" "ubuntu" {
#     most_recent = true
#     filter {
#       name = "name"
#       values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.0.4-amd-64-server"]
#     }
# }

resource "aws_instance" "hello" {
  ami           = "ami-04b6019d38ea93034"
  instance_type = "t2.micro"
  tags = {
    Name = "HelloWorld"
  }
}
