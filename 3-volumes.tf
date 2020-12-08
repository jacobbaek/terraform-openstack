# ===== osd volumes =====
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/blockstorage_volume_v3
#

resource "openstack_blockstorage_volume_v3" "ceph-disk1" {
  count       = length(var.ceph-names)
  region      = "RegionOne"
  name        = "ceph-disk1-${count.index}"
  description = "used as ceph osd in test openstack"
  size        = 5
}

resource "openstack_blockstorage_volume_v3" "ceph-disk2" {
  count       = length(var.ceph-names)
  region      = "RegionOne"
  name        = "ceph-disk2-${count.index}"
  description = "used as ceph osd in test openstack"
  size        = 5
}

resource "openstack_blockstorage_volume_v3" "ceph-disk3" {
  count       = length(var.ceph-names)
  region      = "RegionOne"
  name        = "ceph-disk3-${count.index}"
  description = "used as ceph osd in test openstack"
  size        = 5
}
