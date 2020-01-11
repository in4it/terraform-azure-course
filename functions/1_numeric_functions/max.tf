variable "one" {
  default = 1
}

variable "two" {
  default = 3
}
variable "three" {
  default = 3
}

output "max" {
  value = "${max(var.one,var.two,var.three)}"
}
