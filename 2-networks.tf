# ===== Network and Subnet =====
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/networking_network_v2
# 

resource "openstack_networking_network_v2" "jacobbaek-network" {
  name           = "${var.project-name}-network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet-deploy" {
  name       = "jacob-deploy"
  network_id = openstack_networking_network_v2.jacobbaek-network.id
  cidr       = "${var.deploy-addr}.0/24"
  ip_version = 4
}

resource "openstack_networking_subnet_v2" "subnet-internal" {
  name       = "jacob-internal"
  network_id = openstack_networking_network_v2.jacobbaek-network.id
  cidr       = "${var.internal-addr}.0/24"
  ip_version = 4
}

resource "openstack_networking_subnet_v2" "subnet-storage" {
  name       = "jacob-storage"
  network_id = openstack_networking_network_v2.jacobbaek-network.id
  cidr       = "${var.storage-addr}.0/24"
  ip_version = 4
}

resource "openstack_networking_subnet_v2" "subnet-monitor" {
  name       = "jacob-monitor"
  network_id = openstack_networking_network_v2.jacobbaek-network.id
  cidr       = "${var.monitor-addr}.0/24"
  ip_version = 4
}

#data "openstack_networking_network_v2" "network_2" {
#  name       = var.nat_network
#}
# ===== Deploy(admin) Fixed IP =====
resource "openstack_networking_port_v2" "adminport-deploy" {
  name           = "adminport-deploy"
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-deploy.id
    ip_address = "${var.deploy-addr}.5"
  }
}

resource "openstack_networking_port_v2" "adminport-storage" {
  name           = "adminport-storage"
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-storage.id
    ip_address = "${var.storage-addr}.5"
  }
}

resource "openstack_networking_port_v2" "adminport-monitor" {
  name           = "adminport-monitor"
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-monitor.id
    ip_address = "${var.monitor-addr}.5"
  }
}

# ===== Ceph Fixed IP =====
resource "openstack_networking_port_v2" "cephport-deploy" {
  count = length(var.ceph-names)
  name           = format("%s-%s", "cephport-deploy", count.index)
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-deploy.id
    ip_address = "${var.deploy-addr}.3${count.index}"
  }
}

resource "openstack_networking_port_v2" "cephport-storage" {
  count = length(var.ceph-names)
  name           = format("%s-%s", "cephport-storage", count.index)
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-storage.id
    ip_address = "${var.storage-addr}.3${count.index}"
  }
}

resource "openstack_networking_port_v2" "cephport-monitor" {
  count = length(var.ceph-names)
  name           = format("%s-%s", "cephport-monitor", count.index)
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-monitor.id
    ip_address = "${var.monitor-addr}.3${count.index}"
  }
}

# ===== Controller Fixed IP =====
resource "openstack_networking_port_v2" "ctrlport-deploy" {
  count = length(var.controller-names)
  name           = format("%s-%s", "ctrlport-deploy", count.index)
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-deploy.id
    ip_address = "${var.deploy-addr}.1${count.index}"
  }
}

resource "openstack_networking_port_v2" "ctrlport-internal" {
  count = length(var.controller-names)
  name           = format("%s-%s", "ctrlport-internal", count.index)
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-internal.id
    ip_address = "${var.internal-addr}.1${count.index}"
  }
}

resource "openstack_networking_port_v2" "ctrlport-storage" {
  count = length(var.controller-names)
  name           = format("%s-%s", "ctrlport-storage", count.index)
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-storage.id
    ip_address = "${var.storage-addr}.1${count.index}"
  }
}

resource "openstack_networking_port_v2" "ctrlport-monitor" {
  count = length(var.controller-names)
  name           = format("%s-%s", "ctrlport-monitor", count.index)
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-monitor.id
    ip_address = "${var.monitor-addr}.1${count.index}"
  }
}

# ===== Compute Fixed IP =====
resource "openstack_networking_port_v2" "comport-deploy" {
  count = length(var.compute-names)
  name           = format("%s-%s", "comport-deploy", count.index)
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-deploy.id
    ip_address = "${var.deploy-addr}.2${count.index}"
  }
}

resource "openstack_networking_port_v2" "comport-internal" {
  count = length(var.compute-names)
  name           = format("%s-%s", "comport-internal", count.index)
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-internal.id
    ip_address = "${var.internal-addr}.2${count.index}"
  }
}

resource "openstack_networking_port_v2" "comport-storage" {
  count = length(var.compute-names)
  name           = format("%s-%s", "comport-storage", count.index)
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-storage.id
    ip_address = "${var.storage-addr}.2${count.index}"
  }
}

resource "openstack_networking_port_v2" "comport-monitor" {
  count = length(var.compute-names)
  name           = format("%s-%s", "comport-monitor", count.index)
  network_id     = openstack_networking_network_v2.jacobbaek-network.id
  admin_state_up = "true"

  fixed_ip {
    subnet_id = openstack_networking_subnet_v2.subnet-monitor.id
    ip_address = "${var.monitor-addr}.2${count.index}"
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


# ===== Router =====
#
# 

resource "openstack_networking_router_v2" "jacobbaek-router" {
  name        = "jacobbaek-router"
  description = "router for jacobbaek project"
  external_network_id= var.external-network-uuid
}

resource "openstack_networking_router_interface_v2" "jacobbaek-router-int" {
  router_id = openstack_networking_router_v2.jacobbaek-router.id
  subnet_id = openstack_networking_subnet_v2.subnet-deploy.id
}

