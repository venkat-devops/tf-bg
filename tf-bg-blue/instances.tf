locals {
  subnets = ["${aws_subnet.tf_bg_subnet.*.id}"]

  user_data = <<EOF
    #!/bin/bash
    sudo yum install httpd -y;
    sudo touch /var/www/html/index.html;
    sudo echo "<h1 style=color:blue><center>Hello World v1 - from Blue Environment</h1>" > /var/www/html/index.html;
    sudo service httpd restart;
    sudo systemct enable httpd;
  EOF
}

resource "aws_instance" "tf_bg_ec2" {
  count                  = 3
  ami                    = "ami-c12dcda6"
  instance_type          = "t2.nano"
  subnet_id              = "${element(local.subnets, count.index)}"
  vpc_security_group_ids = ["${aws_security_group.tf_bg_sg.id}"]
  key_name               = "${var.key_pair}"

  user_data = "${local.user_data}"

  tags {
    Name       = "tf-bg-ec2-0${count.index + 1} (v${var.app_ver})"
    AppVersion = "${var.app_ver}"
  }
}

output "ec2_public_ips" {
  value = "${aws_instance.tf_bg_ec2.*.public_ip}"
}
