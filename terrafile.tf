# variable "environment" {}

module "servers" {
  source  = "./servers"

  # environment = "${var.environment}"
}

output "ip_address" {
  value = module.servers.ip_address
}
