#
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_network_v2
# 

resource "openstack_networking_network_v2" "network_1" {
  name           = "jacob-network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  name       = "jacob-subnet"
  network_id = openstack_networking_network_v2.network_1.id
  cidr       = "10.90.90.0/24"
  ip_version = 4
}

data "openstack_networking_network_v2" "network_2" {
  name       = var.nat_network
}

#
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_floatingip_v2
#

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = var.public_network
}

#
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_secgroup_rule_v2
#

resource "openstack_networking_secgroup_v2" "secgroup_1" {
  name        = "secgroup_1"
  description = "My neutron security group"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_1" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup_1.id
}


