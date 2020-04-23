##############################################################################
# Variable block - See each variable description
##############################################################################

##############################################################################
# vnf_cos_instance_id - Vendor provided COS instance-id hosting
#                               F5-BIGIP image.
#                               The value for this variable is enter at offering
#                               onbaording time. This variable is hidden from the user.
##############################################################################
variable "vnf_cos_instance_id" {
  default     = ""
  description = "The COS instance-id hosting the F5-BIGIP qcow2 image."
}

##############################################################################
# vnf_cos_image_url_map - Vendor provided F5-BIGIP image COS url.
#                             The value for this variable is enter at offering
#                             onbaording time.This variable is hidden from the user.
#                         This value is a map, which contains, image URL for different
#                         regions
##############################################################################
variable "vnf_cos_image_url_map" {
  default     = {}
  description = "The COS image object SQL URL for F5-BIGIP qcow2 image."
}

##############################################################################
# subnet_name - Subnet where resources are to be provisioned.
##############################################################################
variable "subnet_id"{
  default = ""
  description =" The id of the subnet where F5-BIGIP VSI to be provisioned."
}
##############################################################################
# ssh_key_name - The name of the public SSH key to be used when provisining F5-BIGIP VSI.
##############################################################################
variable "ssh_key_name" {
  default     = ""
  description = "The name of the public SSH key (VPC Gen 2 SSH Key) to be used when provisining F5-BIGIP VSI."
}

##############################################################################
# vnf_vpc_image_name - The name of the F5-BIGIP custom image to be provisioned in your IBM Cloud account.
##############################################################################
variable "vnf_vpc_image_name" {
  default     = "f5-bigip-15-0-1-0-0-11"
  description = "The name of the F5-BIGIP custom image to be provisioned in your IBM Cloud account."
}

##############################################################################
# vnf_vpc_image_name - The name of your F5-BIGIP Virtual Server to be provisioned
##############################################################################
variable "vnf_instance_name" {
  default     = "f5-1arm-vsi01"
  description = "The name of your F5-BIGIP Virtual Server to be provisioned."
}

##############################################################################
# vnf_profile - The profile of compute CPU and memory resources to be used when provisioning F5-BIGIP VSI.
##############################################################################
variable "vnf_profile" {
  default     = "bx2-2x8"
  description = "The profile of compute CPU and memory resources to be used when provisioning F5-BIGIP VSI. To list available profiles, run `ibmcloud is instance-profiles`."
}

variable "ibmcloud_endpoint" {
  default     = "cloud.ibm.com"
  description = "The IBM Cloud environmental variable 'cloud.ibm.com' or 'test.cloud.ibm.com'"
}
