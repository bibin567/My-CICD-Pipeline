variable "ami" {
  type    = string
  default = "ami-05576a079321f21f8"
}

variable "type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
  default = "aws"
}

variable "ssh_private_key_file" {
  description = "Path to the SSH private key file"
  type        = string
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "Git-Website" {
  ami_name               = "packer-Git-Website ${local.timestamp}"
  instance_type          = var.type
  region                 = "us-east-1"
  source_ami             = var.ami
  ssh_username           = "ec2-user"
  ssh_private_key_file   = var.ssh_private_key_file  # Updated to use variable
  ssh_keypair_name       = var.key_name
  tags = {
    Name = "MyPackerImage"
  }
}

build {
  sources = ["source.amazon-ebs.Git-Website"]
  
  provisioner "shell" {
    script = "./Git-Script.sh"
  }

  post-processor "shell-local" {
    inline = ["echo AMI Created"]
  }
}
