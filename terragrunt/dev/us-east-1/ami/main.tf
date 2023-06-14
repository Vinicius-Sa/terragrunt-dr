data "aws_ami" "ubuntu" {
  owners = ["099720109477"]
  most_recent      = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

output "id" {
  value = data.aws_ami.ubuntu.id
}
