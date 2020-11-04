variable "image_name" {
  default = "centos FIXME"
}

variable "ssh-pubkey" {
  default = "ssh-rsa FIXME"
}

# the below variable have to defined that is provider network.
variable "public_network" {
  default = "external-network FIXME"
}

# the below variable have to defined that can connect provider network.
variable "nat_network" {
  default = "internal-network FIXME"
}
