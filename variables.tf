##############################################################################
# Variable block - See each variable description
##############################################################################

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

##############################################################################
# vnf_bucket_base_name - The base name of the bucket which holds the qcow2 Image, For Ex. If bucket name is bigip-13.1.3-0.0.6.all-1slot-eu-de bigip-13.1.3-0.0.6.all-1slot should be the input here, hyphen(-) and region name will be added by the script before copy.
##############################################################################
variable "vnf_bucket_base_name" {
  default = ""
  description ="The base name of the bucket which holds the qcow2 Image, For Ex. If bucket name is bigip-13.1.3-0.0.6.all-1slot-eu-de bigip-13.1.3-0.0.6.all-1slot should be the input here, hyphen(-) and region name will be added by the script before copy"
}

##############################################################################
# vnf_cos_image_name - The name of the qcow2 Image name stored in the COS Bucket.
##############################################################################
variable "vnf_cos_image_name" {
  default=""
  description = "The name of the qcow2 Image name"
}