data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Ubuntu
}

resource "aws_instance" "web" {
  count         = var.servers
  ami           = var.image_id
  instance_type = "t2.micro"
  key_name      = "giropops-key"
  subnet_id     = "subnet-012078058474d3acd"
  security_groups = ["sg-073029a80d27e1e93"]

  tags = {
    Name = "HelloWorld"
  }
}