##############################################################################
# Variable block - See each variable description
##############################################################################
variable "region" {
  default=""
  description = "The Region where F5 virtual server to be provisioned in. To list available regions, run `ibmcloud is regions`. Supported regions are eu-de, eu-gb, us-south, us-east "
}

variable "generation" {
  default     = 2
  description = "The VPC Generation to target. Valid values are 2 or 1."
}

##############################################################################
# Provider block - Default using logged user creds
##############################################################################
provider "ibm" {
#  ibmcloud_api_key      = "${var.ibmcloud_api_key}"
  generation            = "${var.generation}"
  region                = "${var.region}"
  ibmcloud_timeout      = 300
}

