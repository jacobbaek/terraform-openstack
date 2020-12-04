#
# getting keypair and ...
#

data "local_file" "jacobbaek-pubkey" {
    filename = "/home/jacob/.ssh/id_rsa.pub"
    #filename = "${path.module}/id_rsa.pub"
}

resource "openstack_compute_keypair_v2" "jacobbaek-keypair" {
  name = "jacobbaek-keypair"
  public_key = data.local_file.jacobbaek-pubkey.content
}

#data "openstack_compute_keypair_v2" "jacobbaek-keypair" {
#  name = "jacobbaek-keypair"
#}
