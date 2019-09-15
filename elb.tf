resource "aws_elb" "sud_elb" {
  name = "sud-elb"
  subnets = "${local.pub_sub_ids}"
  security_groups = "${aws_security_group.elbsg.id}"


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
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  instances                   = "${aws_instance.web.*.id}"
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 30

  tags = {
    Name = "sud-elb"
  }
}

resource "aws_security_group" "elbsg" {
  name        = "elb_sg"
  vpc_id      = "${aws_vpc.my_vpc.id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
