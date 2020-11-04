#
#
#
resource "openstack_compute_flavor_v2" "flavor_1" {
  name  = "m1.middle_jacob"
  ram   = "4096"
  vcpus = "2"
  disk  = "30"
}

data "local_file" "pubkey" {
    filename = "${path.module}/pubkey"
}

resource "openstack_compute_keypair_v2" "jacob-test-cloud-key_1" {
  name       = "jacob-test-key"
  public_key = data.local_file.pubkey.content
}
