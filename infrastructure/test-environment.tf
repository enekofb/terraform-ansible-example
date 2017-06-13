## AWS provider
provider "aws" {
  region = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

## Setting up VPC
resource "aws_vpc" "eneko-vpc" {
  cidr_block = "10.20.0.0/16"
  tags = {
    Name = "eneko"
  }
}

## Setting up public network
resource "aws_internet_gateway" "eneko-vpc-gw" {
  vpc_id = "${aws_vpc.eneko-vpc.id}"
  tags = {
    Name = "eneko"
  }
}

resource "aws_route_table" "eneko-vpc-routing-table" {
  vpc_id = "${aws_vpc.eneko-vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.eneko-vpc-gw.id}"
  }

  tags = {
    Name = "eneko.public"
  }

}


resource "aws_subnet" "public" {
  count ="${var.zone_count}"
  vpc_id = "${aws_vpc.eneko-vpc.id}"
  cidr_block = "${lookup(var.public_subnet_cidr_block, count.index)}"

  availability_zone = "${lookup(var.eu-west-availablity-zone, count.index)}"

  tags = {
    Name = "eneko.public"
  }

}

resource "aws_route_table_association" "public" {
  count ="${var.zone_count}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.eneko-vpc-routing-table.id}"
}


resource "aws_security_group" "eneko" {
  vpc_id = "${aws_vpc.eneko-vpc.id}"
  description = "allows ssh and etcd traffic to etcd instances"

  tags = {
    Name = "eneko.private"
  }

  ingress {
    from_port = 0
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

}

resource "aws_eip" "eneko-bastion-eip" {
  vpc = true
  instance = "${aws_instance.eneko-ec2.id}"
}

resource "aws_instance" "eneko-ec2" {
  count ="${var.zone_count}"
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  vpc_security_group_ids = [
    "${aws_security_group.eneko.id}"]
  ami = "ami-7abd0209"
  instance_type = "t2.micro"
  key_name = "${var.key_name}"

  tags = {
    Name = "eneko.private"
  }
}
