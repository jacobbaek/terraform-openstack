#
#
#

data "openstack_compute_flavor_v2" "small" {
  vcpus = 1
  ram   = 512
}

data "openstack_images_image_v2" "ubuntu" {
  name        = "Ubuntu 16.04"
  most_recent = true

  properties = {
    key = "value"
  }
}

resource "openstack_compute_instance_v2" "testvm" {
  name            = "test-vm"
  image_name      = "cirros"
  flavor_name     = "m1.tiny"
  key_pair        = openstack_compute_keypair_v2.jacob-test-cloud-key.name
  security_groups = ["default"]

  network {
    name = "selfservice"
  }
}
