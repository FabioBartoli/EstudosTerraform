variable "blocks" {}

module "servers" {
  source  = "./servers"
  blocks = "${var.blocks}"
}

output "ip_address" {
  value = module.servers.ip_address
}
