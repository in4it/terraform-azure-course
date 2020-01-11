variable "range" {
  default = "10.0.0.1/16"
}

output "cidrnetmask" {
  value = "${cidrnetmask(var.range)}"
}