
resource "openstack_compute_flavor_v2" "flavor" {
  name  = "m1.standard"
  ram   = "4096"
  vcpus = "4"
  disk  = "30"
}

resource "openstack_compute_keypair_v2" "jacob-test-cloud-key" {
  name       = "jacob-test-key"
  public_key = var.ssh_pubkey
}

