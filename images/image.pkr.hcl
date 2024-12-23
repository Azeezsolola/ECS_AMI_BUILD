packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}


variable "aws_source_ami" {
  default = "amzn2-ami-ecs-hvm-2.0.20241108-x86_64-ebs"
}

variable "aws_instance_type" {
  default = "c4.large"
}

variable "ami_name" {
  default = "ami-stack-golden-image-01_ECS4"
}

variable "component" {
  default = "clixx"
}


variable "aws_accounts" {
  type = list(string)
  # default= ["495599767034","560089993749"]
  default= ["418272760069","495599767034"]
}

variable "ami_regions" {
  type = list(string)
  default =["us-east-1"]
}

variable "aws_region" {
  default = "us-east-1"
}

data "amazon-ami" "source_ami" {
  filters = {
    name = "${var.aws_source_ami}"
  }
  most_recent = true
  owners      = ["336528460023","amazon"]
  region      = "${var.aws_region}"
}




# locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }


# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioners and post-processors on a
# source.


source "amazon-ebs" "amazon_ebs" {
  # assume_role {
  #   role_arn     = "arn:aws:iam::560089993749:role/Engineer"
  # }
  ami_name                = "${var.ami_name}"
  ami_regions             = "${var.ami_regions}"
  ami_users               = "${var.aws_accounts}"
  snapshot_users          = "${var.aws_accounts}"
  encrypt_boot            = false
  instance_type           = "${var.aws_instance_type}"
  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/xvda"
    encrypted             = false
    volume_size           = 30
    volume_type           = "gp2"
  }
  region                  = "${var.aws_region}"
  source_ami              = "${data.amazon-ami.source_ami.id}"
  ssh_pty                 = true
  ssh_timeout             = "5m"
  ssh_username            = "ec2-user"
}


# a build block invokes sources and runs provisioning steps on them.
build {
  sources = ["source.amazon-ebs.amazon_ebs"]
  provisioner "shell" {
    script = "../scripts/setup.sh"
  }
}

