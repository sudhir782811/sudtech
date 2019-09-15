provider "aws" {
  region  = "${var.region}"
}

# need to kept our tfstate file on remote like s3, so that multiple devloper work on same project

terraform {
  backend "s3" {
    bucket = "sud-terra7828"  # bucket must be created on s3 with this name
    key    = "sud/terraform.tfstate" # name could be anything but extention should be .tfstate 
    region = "eu-central-1"
    dynamodb_table = "terraform1-lock" #create dynamodb table with this name keyid must with name "LockID"
  }
}

# creating vpc
resource "aws_vpc" "my_vpc" {
  cidr_block       = "${var.vpc_cidr}" # parametrise the value with the help of varaible in terraform to reusable
  instance_tenancy = "default"

  tags = "${var.vpc_tag}"
}

# subnet creaton

resource "aws_subnet" "public" {
  #count = "${length(var.azs)}" # we are using length fuction to counth the lenght of AZ and create subnets accordingly
  #count = "${length(data.aws_availability_zones.azs.names)} ## to make more danamic keep this value in local
  count = "${length(local.az_names)}"
  vpc_id     = "${aws_vpc.my_vpc.id}"
  map_public_ip_on_launch = true
  #cidr_block = "${element(var.subnet_cidrs,count.index)}" # using element fuction to pick one element at a time from list
  availability_zone = "${element(local.az_names,count.index)}" # use "availablity_zone" to make subnet in each AZ
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index + 1)}"  # 0+1=1 so it start from 10.0.1.0/24
  /*
  use "cidrsubnet" to create subnet like below form
  vpc_cidr+8, count.index = 10.0.0.0/16+8 >> 10.0.1.0/24
                                          >> 10.0.2.0/24
                                          >> 10.0.3.0/24

  */
  tags = {
    Name = "publicsubnet-${count.index + 1}"
  }
}

######## Again this is hard coded if we change the region, we are forced to change the AZ list in variable file
### we can made danamic with the "terraform data source"


## CREATING INTERNET GATEWAY

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  tags = {
    Name = "igw"
  }
}

####### CREATING ROUTE TABLE

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name = "publicrt"
  }
}

#### public subnet association to route table

resource "aws_route_table_association" "a" { 
  count = "${length(local.az_names)}"
  #subnet_id      = "${aws_subnet.public.*.id[count.index]}"
  subnet_id      = "${local.pub_sub_ids[count.index]}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

# whether we can use avobe code thrice or we can go through loop "count"


