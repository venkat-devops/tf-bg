data "aws_route53_zone" "tf_bg_r53_zone" {
  name = "${var.domain}.com."
}

resource "aws_route53_record" "tf_bg_r53" {
  zone_id = "${data.aws_route53_zone.tf_bg_r53_zone.zone_id}"
  name    = "v${var.app_ver}.${var.domain}.com"
  type    = "A"

  alias {
    name                   = "dualstack.${aws_elb.tf_bg_elb.dns_name}"
    zone_id                = "${aws_elb.tf_bg_elb.zone_id}"
    evaluate_target_health = false
  }
}
