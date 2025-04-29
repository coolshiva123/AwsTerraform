variable "ami_id" {}
variable "ins_type" {}
variable "tags_argo_minikube" {
  type = map(any)
}
variable "minikube01_disksize" {}
variable "minikube01_disktype" {}
variable "minikube01_key_name" {}
variable "minikube01_pubkey_val" {}
variable "minikube01_secgrp_name" {}
variable "region_var" {}
