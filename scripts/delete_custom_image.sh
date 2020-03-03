#!/bin/bash

# Exit if any of the intermediate steps fail
set -e

####
## USAGE: Called by bash when exiting on error.
## Will dump stdout and stderr from lgo file to stdout
####
function error_exit() {
    cat "$MSG_FILE"
    exit 1
}

####
## USAGE: _log <log_message>
####
function _log() {
    echo "$1" > "$MSG_FILE"
}

####
## USAGE: parse_input
## Parsing input from the terraform and assigning to script variable.
## 1. custom_image_id - Custom Image ID which needs to be deleted after vsi creation.
## 2. local_iam_auth_token - Local IAM token
####
function parse_input() {
    _log "## Entering function: ${FUNCNAME[0]}"
    eval "$(jq -r '@sh "custom_image_id=\(.custom_image_id) ibmcloud_endpoint=\(.ibmcloud_endpoint)"')"
    _log "## Exiting function: ${FUNCNAME[0]}"
}

####
## USAGE: select_riaas_endpoint
## selecting the riaas endpoint based on the IBM end point and assigning to script variable.
## 1. ibmcloud_endpoint - IBM Cloud endpoint can be either cloud.ibm.com or test.cloud.ibm.com.
##                        As of now, there is no implementation to take the riaas end point
##                        from terraform.  Hence, hot coded it.
####
function select_riaas_endpoint() {
    if [ "$ibmcloud_endpoint" == "cloud.ibm.com" ]
    then
        rias_endpoint="https://us-south.iaas.cloud.ibm.com"
    else
        rias_endpoint="https://us-south-stage01.iaasdev.cloud.ibm.com"
    fi
}

####
## USAGE: delete_image
## Delete Custom Image from User Account after VSI Creation.
####
function delete_image() {
    _log "## Entering function: ${FUNCNAME[0]}"
    # Command to delete Custom Image from user account.
    # IC_IAM_TOKEN - Provided by IBM Cloud Schematics
    curl -X DELETE \
    "$rias_endpoint/v1/images/$custom_image_id?version=2020-01-28&generation=2" \
    -H "Authorization: Bearer $IC_IAM_TOKEN" &> "$MSG_FILE"
    _log "## Exiting function: ${FUNCNAME[0]}"
}

####
## USAGE: produce_output
## Returnig output to terraform variable.
## Ex.
##    {
##        "custom_image_id": "r006-7d9aa110-a111-4386-a2a3-65568f2845cb"
##    }
####
function produce_output() {
    _log "## Entering function: ${FUNCNAME[0]}"
    jq -n --arg custom_image_id "$custom_image_id" '{"custom_image_id":$custom_image_id}'
    _log "## Exiting function: ${FUNCNAME[0]}"
}

#### Main Script execution starts here.
# Global variables shared by functoins
MSG_FILE="/tmp/out.log" && rm -f "$MSG_FILE" &> /dev/null && touch "$MSG_FILE" &> /dev/null
rias_endpoint=""

# Main Script functions starts here
printenv
parse_input
select_riaas_endpoint
delete_image
produce_output
