resource "aws_subnet" "privatesub" {
  count = "${length(local.az_names)}"
  vpc_id     = "${aws_vpc.my_vpc.id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, length(local.az_names) + count.index)}"
  availability_zone = "${element(local.az_names, count.index)}"

  tags = {
    Name = "privatesubnet-${count.index + 1}"
  }
}

resource "aws_route_table" "privatert" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }

  tags = {
    Name = "privatert"
  }
}

# private subnet association

resource "aws_route_table_association" "privateasso" {
count = "${length(local.az_names)}"
#subnet_id      = "${aws_subnet.privatesub.*.id}"
subnet_id      = "${local.pri_sub_ids[count.index]}"
route_table_id = "${aws_route_table.privatert.id}"
}