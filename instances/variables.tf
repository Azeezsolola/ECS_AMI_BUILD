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
    default="vpc-0269ddbcb1b88dbda"
}

variable "subnets" {
  type = list(string)
  default=[
    "subnet-04061c8bd163a910c",
    "subnet-0a39cb75d8a4481bb",
   ]
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "packer_rsa.pub"
}

variable "ami_name" {
  default = "ami-stack-01"
}
