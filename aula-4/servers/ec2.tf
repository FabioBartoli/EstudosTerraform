data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Ubuntu
}

resource "aws_instance" "web" {
  count         = var.servers == "production" ? 2 : 1
  ami           = var.image_id
  instance_type = count.index < 1 ? "t1.micro" : "t2.micro"
  key_name      = "giropops-key"
  subnet_id     = "subnet-0f9354c79f0f58f70"
  security_groups = var.sg

  tags = {
    Name = "HelloWorld"
    Env = var.environment
  }
}

resource "aws_eip" "ip" {
  vpc = true
  instance = aws_instance.web[0].id
}

resource "aws_instance" "web2" {
  ami           = var.image_id
  for_each = toset(var.instance_type)
  instance_type = each.value
  key_name      = "giropops-key"
  subnet_id     = "subnet-0f9354c79f0f58f70"
  security_groups = ["sg-073029a80d27e1e93"]

  tags = {
    Name = "HelloWorld"
  }

  depends_on = [aws_instance.web]
}