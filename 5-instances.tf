#
#
#

data "openstack_compute_flavor_v2" "flavor-middle" {
  name = "m1.medium"
}

data "openstack_images_image_v2" "centos7-image" {
  name        = "CentOS-7-x86_64-1901"
  most_recent = true

  properties = {
    key = "value"
  }
}

resource "openstack_compute_instance_v2" "testvm" {
  name            = "jacobbaek-testvm"
  image_name      = data.openstack_images_image_v2.centos7-image.name
  flavor_name     = data.openstack_compute_flavor_v2.flavor-middle.name
  key_pair        = openstack_compute_keypair_v2.jacobbaek-keypair.name
  #key_pair        = data.openstack_compute_keypair_v2.jacobbaek-keypair.name
  security_groups = ["default", openstack_networking_secgroup_v2.secgroup-openstack.name]

#  network {
#    name = data.openstack_networking_network_v2.jacobbaek-network.name
#  }

  network {
    name = openstack_networking_network_v2.jacobbaek-network.name
    port = openstack_networking_port_v2.port-sub1.id
  }

#  connection {
#    user        = "root"
#    host        = "${openstack_networking_port_v2.port-sub1.fixed_ip.0.ip_address}"
#    private_key = "~/path/to/key"
#  }
#
#  provisioner "remote-exec" {
#    inline = [
#      "echo terraform executed > /tmp/foo",
#    ]
#  }

  depends_on = [ openstack_networking_subnet_v2.subnet_1, openstack_networking_subnet_v2.subnet_2, openstack_networking_subnet_v2.subnet_3, openstack_networking_subnet_v2.subnet_4 ]
}

resource "openstack_compute_interface_attach_v2" "interface_1" {
  instance_id = openstack_compute_instance_v2.testvm.id
  network_id  = openstack_networking_network_v2.jacobbaek-network.id
  fixed_ip    = "22.22.22.50"
}

resource "openstack_compute_interface_attach_v2" "interface_2" {
  instance_id = openstack_compute_instance_v2.testvm.id
  network_id  = openstack_networking_network_v2.jacobbaek-network.id
  fixed_ip    = "33.33.33.50"
}

resource "openstack_compute_volume_attach_v2" "volume_1" {
  instance_id = openstack_compute_instance_v2.testvm.id
  volume_id   = openstack_blockstorage_volume_v3.volume-1.id
}

#resource "openstack_compute_floatingip_associate_v2" "extip" {
#  #floating_ip = openstack_networking_floatingip_v2.fip_1.address
#  instance_id = openstack_compute_instance_v2.testvm.id
#  fixed_ip    = openstack_compute_instance_v2.testvm.network.0.fixed_ip_v4
#}
