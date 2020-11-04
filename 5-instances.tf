#
#
#

data "openstack_compute_flavor_v2" "flavor" {
  name = "m1.small"
#  vcpus = 2
#  ram   = 2048
}

data "openstack_images_image_v2" "image" {
  name        = "centos8"
  most_recent = true

  properties = {
    key = "value"
  }
}

resource "openstack_compute_instance_v2" "testvm" {
  name            = "test-vm"
  image_name      = data.openstack_images_image_v2.image.name
  flavor_name     = data.openstack_compute_flavor_v2.flavor.name
  key_pair        = openstack_compute_keypair_v2.jacob-test-cloud-key_1.name
  security_groups = ["default", openstack_networking_secgroup_v2.secgroup_1.name]

  network {
    name = data.openstack_networking_network_v2.network_2.name
  }

  network {
    name = openstack_networking_network_v2.network_1.name
  }

  depends_on = [ openstack_networking_subnet_v2.subnet_1, ]
}

resource "openstack_compute_floatingip_associate_v2" "extip" {
  floating_ip = openstack_networking_floatingip_v2.fip_1.address
  instance_id = openstack_compute_instance_v2.testvm.id
  fixed_ip    = openstack_compute_instance_v2.testvm.network.0.fixed_ip_v4
}
