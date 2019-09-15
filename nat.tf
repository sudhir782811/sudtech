data "aws_ami" "nat" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}

resource "aws_instance" "nat" {
  ami           = "${data.aws_ami.nat.id}"
  subnet_id = "${local.pub_sub_ids[0]}"     # we want to create one nat instance in one public subnet
  instance_type = "t2.micro"

  tags = {
    Name = "nat-instance"
  }
}