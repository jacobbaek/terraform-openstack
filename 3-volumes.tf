#
# https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs/resources/blockstorage_volume_v3
#

resource "openstack_blockstorage_volume_v3" "volume-1" {
  region      = "RegionOne"
  name        = "ceph-osd"
  description = "used as ceph osd in test openstack"
  size        = 5
}
