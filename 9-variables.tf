variable "image_name" {
  default = "centos_FIXME"
}

variable "ssh-pubkey" {
  default = "ssh-rsa_FIXME "
}

# the below variable have to defined that is provider network.
variable "public_network" {
  default = "external-network_FIXME"
}

# the below variable have to defined that can connect provider network.
variable "nat_network" {
  default = "internal-network_FIXME"
}
