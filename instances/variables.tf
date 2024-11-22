# variable "cidr_vpc" {
#   description = "CIDR block for the VPC"
#   default     = "10.1.0.0/16"
# }
# variable "cidr_subnet" {
#   description = "CIDR block for the subnet"
#   default     = "10.1.0.0/24"
# }

variable "environment_tag" {
  description = "Environment tag"
  default     = "Learn"
}

variable "region"{
  description = "The region Terraform deploys your instance"
  default     = "us-east-1"
}

variable "vpc_id"{
    default="vpc-09e857bec0c88c606"
}

variable "subnets" {
  type = list(string)
  default=[
    "subnet-031e2f4af1fac5d14",
    "subnet-089011be431b9f4a4",
   ]
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "packer_rsa.pub"
}

variable "ami_name" {
  default = "ami-stack-golden-image-01_ECS4"
}
