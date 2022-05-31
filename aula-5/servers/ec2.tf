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

  dynamic "ebs_block_device" {
    for_each = var.blocks
    content {
      device_name = ebs_block_device.value["device_name"]
      volume_size = ebs_block_device.value["volume_size"]
      volume_type = ebs_block_device.value["volume_type"]
    }
  }

  tags = {
    #Name = "HelloWorld ${var.name}"
    Name = "Hello, %{ if var.name == "Fabio" }${var.name}%{ else }Invalido%{ endif }!"
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