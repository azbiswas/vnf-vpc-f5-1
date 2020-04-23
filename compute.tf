##############################################################################
# This file creates the compute instances for the solution.
# - Virtual Server using F5-BIGIP custom image
# - Two virtual servers initialized with nginx to demo Load Balancing using F5-BIGIP
##############################################################################

##############################################################################
# Read/validate sshkey
##############################################################################
data "ibm_is_ssh_key" "f5_ssh_pub_key" {
  name = "${var.ssh_key_name}"
}

##############################################################################
# Read/validate vsi profile
##############################################################################
data "ibm_is_instance_profile" "vnf_profile" {
  name = "${var.vnf_profile}"
}

##############################################################################
# Create F5-BIGIP virtual server.
##############################################################################
resource "ibm_is_instance" "f5_vsi" {
  name           = "${var.vnf_instance_name}"
  image          = "${data.ibm_is_image.f5_custom_image.id}"
  profile        = "${data.ibm_is_instance_profile.vnf_profile.name}"
  resource_group = "${data.ibm_resource_group.rg.id}"

  primary_network_interface {
    subnet = "${data.ibm_is_subnet.f5_subnet1.id}"
  }

  vpc  = "${data.ibm_is_subnet.f5_subnet1.vpc}"
  zone = "${data.ibm_is_subnet.f5_subnet1.zone}"
  keys = ["${data.ibm_is_ssh_key.f5_ssh_pub_key.id}"]

  # user_data = "$(replace(file("f5-userdata.sh"), "F5-LICENSE-REPLACEMENT", var.vnf_license)"

  //User can configure timeouts
  timeouts {
    create = "10m"
    delete = "10m"
  }
  # Hack to handle some race condition; will remove it once have root caused the issues.
  provisioner "local-exec" {
    command = "sleep 30"
  }
}

# Delete custom image from the local user after VSI creation.
data "external" "delete_custom_image" {
  depends_on = ["ibm_is_instance.f5_vsi"]
  program    = ["bash", "${path.module}/scripts/delete_custom_image.sh"]

  query = {
    custom_image_id   = "${data.ibm_is_image.f5_custom_image.id}"
    region            = "${var.region}"
  }
}

output "delete_custom_image" {
  value = "${lookup(data.external.delete_custom_image.result, "custom_image_id")}"
}
