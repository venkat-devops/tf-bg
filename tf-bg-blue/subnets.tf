locals {
  subnet_count = 3
  azs          = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

resource "aws_subnet" "tf_bg_subnet" {
  count                   = "${local.subnet_count}"
  vpc_id                  = "${var.vpc_id}"
  availability_zone       = "${element(local.azs, count.index)}"
  cidr_block              = "172.31.${63 + count.index + 1}.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "${element(local.azs, count.index)} (v${var.app_ver})"
  }
}
