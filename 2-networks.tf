# ===== Network and Subnet =====
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_network_v2
# 

resource "openstack_networking_network_v2" "jacobbaek-network" {
  name           = "jacobbaek-network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_1" {
  name       = "jacob-subnet1"
  network_id = openstack_networking_network_v2.jacobbaek-network.id
  cidr       = "11.11.11.0/24"
  ip_version = 4
}

resource "openstack_networking_subnet_v2" "subnet_2" {
  name       = "jacob-subnet2"
  network_id = openstack_networking_network_v2.jacobbaek-network.id
  cidr       = "22.22.22.0/24"
  ip_version = 4
}

resource "openstack_networking_subnet_v2" "subnet_3" {
  name       = "jacob-subnet3"
  network_id = openstack_networking_network_v2.jacobbaek-network.id
  cidr       = "33.33.33.0/24"
  ip_version = 4
}

resource "openstack_networking_subnet_v2" "subnet_4" {
  name       = "jacob-subnet4"
  network_id = openstack_networking_network_v2.jacobbaek-network.id
  cidr       = "44.44.44.0/24"
  ip_version = 4
}

#data "openstack_networking_network_v2" "network_2" {
#  name       = var.nat_network
#}

# ===== Fixed IP =====
resource "openstack_networking_port_v2" "port-sub1" {
  name           = "port_1"
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet_1.id
    ip_address = "11.11.11.50"
  }
}

# ===== Floating IP =====
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/compute_floatingip_v2
#

#resource "openstack_networking_floatingip_v2" "fip_1" {
#  pool = var.public_network
#}

# ===== Security Group =====
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_secgroup_rule_v2
#

resource "openstack_networking_secgroup_v2" "secgroup-openstack" {
  name        = "secgroup_openstack"
  description = "security group for openstack on openstack service"
}

resource "openstack_networking_secgroup_rule_v2" "openstack-secgroup-rule" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8080
  port_range_max    = 8080
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.secgroup-openstack.id
}

