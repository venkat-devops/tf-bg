# VPC
resource "aws_vpc" "tf_bg_vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "tf-bg-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "tf_bg_igw" {
  vpc_id = "${aws_vpc.tf_bg_vpc.id}"

  tags {
    Name = "tf-bg-igw"
  }
}

# Route Table
resource "aws_route_table" "tf_bg_public_rt" {
  vpc_id = "${aws_vpc.tf_bg_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf_bg_igw.id}"
  }

  tags {
    Name = "tf-bg-rt"
  }
}

# Route table association
resource "aws_route_table_association" "tf_bg_rt_assoc" {
  count          = 3
  subnet_id      = "${element(aws_subnet.tf_bg_subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.tf_bg_public_rt.id}"
}
