provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_s3_bucket" "tfbuckt" {

}
resource "aws_instance" "test_server" {
  ami           = "ami-03d8b47244d950bbb"
  instance_type = "t2.micro"
  tags = {
    Name = "WebAppServer"
  }
}