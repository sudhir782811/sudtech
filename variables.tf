variable "vpc_cidr" {
  description = "chhose vpc cidr"
  type        = "string"
  default     = "10.0.0.0/16"
}

variable "region" {                  # again this hard coded if we change the region we have change the list of 
  description = "chhose vpc region"  # availablity zone then we can prevent with "terraform data sources"
  type        = "string"
  default     = "eu-central-1"

} 

variable "vpc_tag" {
  description = "chhose vpc tag"
  type        = "map"
  default     = {
      Name = "tfvpc"
  }
}

# creating subnets 

#variable "subnet_cidrs" {
# description = "create subnets"
# type        = "list"
# default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

#} 

#variable "azs" {     ##### commenting because we are using data source to make it danamic
# type        = "list"
# default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]

#} 


variable "web_instance_count" {
  description = "chhose web count"
  type        = "string"
  default     = "1"
}

variable "web_amis" {
  description = "chhose ami for stack"
  type        = "map"
  default     = {
    eu-central-1 = "ami-00aa4671cbf840d82"
    ap-south-1 = "ami-0cb0e70f44e1a4bb5"
  }
}