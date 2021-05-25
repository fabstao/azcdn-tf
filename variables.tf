# Landing Zone variables

variable "resgroup" {
  type    = string
  default = "suracdn"
}

variable "lzlocation" {
  type    = string
  default = "East US"
}

variable "openv" {
  type    = string
  default = "dll"
}

variable "origin_names" {
  type    = list(string)
  default = ["staticwebapp", "staticblob"]
}

variable "origin_hostnames" {
  type    = list(string)
  default = ["zealous-tree-0d0c3ea0f.azurestaticapps.net", "demoblobstatblob.z13.web.core.windows.net"]
}

variable "cdnprofile" {
  type    = string
  default = "cdn-profile"
}

variable "endpoint" {
  type    = string
  default = "cdnep"
}

variable "origingroup" {
  type    = string
  default = "TestOG1"
}

#    command     = "./multioriginep.ps1 -ResourceGroup ${var.resgroup} -CdnProfile ${var.cdnprofile} -Endpoint ${var.endpoint} -OriginGroup ${var.origingroup} -Origin1 ${var.origin_names[0]} -Origin2 ${var.origin_names[1]} -Hostname2 ${var.origin_hostnames[1]}"
