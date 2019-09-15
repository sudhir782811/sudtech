data "aws_ami" "web" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical

}


resource "aws_instance" "web" {
  count = "${var.web_instance_count}"
  #ami           = "${var.web_amis[eu-central-1]}" this is again hardcoded
  ami           = "${var.web_amis[var.region]}"
  instance_type = "t2.micro"
  user_data = "${file("script/apache.sh")}"
  #subnet_id = "${local.pub_sub_ids[count.index]}" ## due to unsuported subnet i decide to create web in one subnet
  subnet_id = "${local.pub_sub_ids[1]}"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  tags = {
    Name = "web-${count.index + 1}"
  }
}
