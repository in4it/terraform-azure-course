variable "bcrypt" {
  default = "Bcrypt all this information please!"
}
output "bcrypt_no_cost" {
  value = "${bcrypt(var.bcrypt)}"
}

output "bcrypt_10_cost" {
  value = "${bcrypt(var.bcrypt, 10)}"
}

output "bcrypt_12_cost" {
  value = "${bcrypt(var.bcrypt, 12)}"
}