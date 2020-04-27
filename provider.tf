##############################################################################
# Variable block - See each variable description
##############################################################################

locals {
  api_key = "${var.ibmcloud_svc_api_key}"
}

##############################################################################
# ibmcloud_svc_api_key - Cloud Service apikey hosting the F5-BIGIP 
#                            image in COS. This variable is not shown to user.
#                            The value for this variable is enter at offering
#                            onbaording time.
##############################################################################
variable "ibmcloud_svc_api_key" {
 default      = ""
 type         = "string"
 description  = "The APIKey of the IBM Cloud service account that is hosting the F5-BIGIP qcow2 image file. This should be a the API Key of a Service ID in the account"
}

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

##############################################################################
# Provider block - Alias initialized tointeract with VNFSVC account
##############################################################################
provider "ibm" {
  alias                 = "vfnsvc"
  ibmcloud_api_key      = "${local.api_key}"
  generation            = "${var.generation}"
  region                = "${var.region}"
  ibmcloud_timeout      = 300
}
