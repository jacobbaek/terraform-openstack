#
# getting(or creation) keypair and flavor, glance image
#

# ===== creation keypair =====
data "local_file" "local-pubkey" {
    filename = "/home/jacob/.ssh/id_rsa.pub"
    #filename = "${path.module}/id_rsa.pub"
}

resource "openstack_compute_keypair_v2" "keypairname" {
  name = "jacobbaek-keypair"
  public_key = data.local_file.local-pubkey.content
}

###
### if you have already keypair in openstack, you should get the keypair with data direction.
###
# data "openstack_compute_keypair_v2" "jacobbaek-keypair" {
#   name = "jacobbaek-keypair"
# }

# ===== getting flavor and glance image =====
data "openstack_compute_flavor_v2" "flavortype" {
  name = var.flavor-name
}

data "openstack_images_image_v2" "imagetype" {
  name        = var.image-name
  most_recent = true

  properties = {
    key = "value"
  }
}

