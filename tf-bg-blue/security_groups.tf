resource "aws_security_group" "tf_bg_sg" {
  description = "Terraform Blue/Green"
  vpc_id      = "${aws_vpc.tf_bg_vpc.id}"
  name        = "tf-bg-sg-v${var.app_ver}"

  tags {
    Name = "tf-bg-sg (v${var.app_ver})"
  }
}

resource "aws_security_group_rule" "tf_bg_sg_ir" {
  type              = "ingress"
  security_group_id = "${aws_security_group.tf_bg_sg.id}"
  from_port         = -1
  to_port           = 0
  protocol          = "-1"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "tf_bg_sg_er" {
  type              = "egress"
  security_group_id = "${aws_security_group.tf_bg_sg.id}"
  from_port         = -1
  to_port           = 0
  protocol          = "-1"

  cidr_blocks = ["0.0.0.0/0"]
}
