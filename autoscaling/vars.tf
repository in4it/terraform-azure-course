variable "location" {
  type    = string
  default = "westeurope"
}

variable "zones" {
  type    = list(string)
  default = []
}
variable "ssh-source-address" {
  type    = string
  default = "*"
}
