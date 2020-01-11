variable "substring" {
  default = "SOME are CAPS"
}

output "substr" {
  value = "${substr(var.substring, 5, 3)}"
}