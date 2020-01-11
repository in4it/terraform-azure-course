variable "string" {
  default = "SOME are CAPS"
}

output "lower" {
  value = "${lower(var.string)}"
}