# ===== =====
#
#
data "template_file" "deploy-user-data" {
  template = file("templates/deploy-cloud-init")
}

# ===== Creation deploy instance =====
resource "openstack_compute_instance_v2" "deploy-instances" {
  name            = format("%s-%s", var.project-name, "deploy")
  image_name      = data.openstack_images_image_v2.imagetype.name
  flavor_name     = data.openstack_compute_flavor_v2.flavortype.name
  key_pair        = openstack_compute_keypair_v2.keypairname.name
  #key_pair        = data.openstack_compute_keypair_v2.jacobbaek-keypair.name
  security_groups = ["default", openstack_networking_secgroup_v2.secgroup-openstack.name]
  user_data       = data.template_file.compute-user-data.rendered

#  network {
#    name = data.openstack_networking_network_v2.jacobbaek-network.name
#  }

  network {
    name = openstack_networking_network_v2.jacobbaek-network.name
    port = openstack_networking_port_v2.adminport-deploy.id
  }

  network {
    name = openstack_networking_network_v2.jacobbaek-network.name
    port = openstack_networking_port_v2.adminport-storage.id
  }

  network {
    name = openstack_networking_network_v2.jacobbaek-network.name
    port = openstack_networking_port_v2.adminport-monitor.id
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

  depends_on = [ openstack_networking_subnet_v2.subnet-deploy, openstack_networking_subnet_v2.subnet-internal, openstack_networking_subnet_v2.subnet-storage, openstack_networking_subnet_v2.subnet-monitor ]
}

#resource "openstack_compute_interface_attach_v2" "interface_deploy" {
#  count = length(var.ceph-names)
#  instance_id = openstack_compute_instance_v2.ceph-instances[count.index].id
#  network_id  = openstack_networking_network_v2.jacobbaek-network.id
#  fixed_ip    = "11.11.11.5${count.index}"
#}

#resource "openstack_compute_interface_attach_v2" "interface_internal" {
#  count = length(var.ceph-names)
#  instance_id = openstack_compute_instance_v2.ceph-instances[count.index].id
#  network_id  = openstack_networking_network_v2.jacobbaek-network.id
#  fixed_ip    = "22.22.22.5${count.index}"
#}
#
#resource "openstack_compute_interface_attach_v2" "interface_storage" {
#  count = length(var.ceph-names)
#  instance_id = openstack_compute_instance_v2.ceph-instances[count.index].id
#  network_id  = openstack_networking_network_v2.jacobbaek-network.id
#  fixed_ip    = "33.33.33.5${count.index}"
#}
#
#resource "openstack_compute_volume_attach_v2" "ceph-volumes" {
#  count = length(var.ceph-names)
#  instance_id = openstack_compute_instance_v2.ceph-instances[count.index].id
#  volume_id   = openstack_blockstorage_volume_v3.ceph-volume[count.index].id
#}

#resource "openstack_compute_floatingip_associate_v2" "extip" {
#  count = length(var.ceph-names)
#  #floating_ip = openstack_networking_floatingip_v2.fip_1.address
#  instance_id = openstack_compute_instance_v2.ceph-instances[count.index].id
#  fixed_ip    = openstack_compute_instance_v2.ceph-instances[count.index].network.0.fixed_ip_v4
#}
