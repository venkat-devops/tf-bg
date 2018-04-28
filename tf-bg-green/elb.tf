resource "aws_elb" "tf_bg_elb" {
  name            = "tf-bg-elb-v${var.app_ver}"
  subnets         = ["${aws_subnet.tf_bg_subnet.*.id}"]
  security_groups = ["${aws_security_group.tf_bg_sg.id}"]

  instances = ["${aws_instance.tf_bg_ec2.*.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  tags {
    Name = "tf-bg-elb-v${var.app_ver}"
  }
}

output "load_balancer_dns" {
  value = "${aws_elb.tf_bg_elb.dns_name}"
}
