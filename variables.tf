# names
variable "project-name" {
  default = "jacobbaek"
}

variable "ceph-names" {
  type = list(string)
  default = ["ceph001", "ceph002", "ceph003"]
}

variable "controller-names" {
  type = list(string)
  default = ["ctrl001"]
}

variable "compute-names" {
  type = list(string)
  default = ["com001"]
}
# 
variable "image-name" {
  default = "image FIXME"
}

variable "flavor-name" {
  default = "m1.medium"
}

# networks
# the below variable have to defined that is provider network.
variable "deploy-addr" {
  default = "11.11.11"
}

variable "internal-addr" {
  default = "22.22.22"
}

variable "storage-addr" {
  default = "33.33.33"
}

variable "monitor-addr" {
  default = "44.44.44"
}

# should check the external's network uuid that will use at the vrouter.
variable "external-network-uuid" {
  default = "external-network-uuid FIXME"
}

variable "pubkey" {
  default = "pubkey FIXME"
}
