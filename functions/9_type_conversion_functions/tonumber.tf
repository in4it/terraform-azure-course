variable "a_string" {
  type = string
  default = "100.2"
}


output "number" {
  value = "${tonumber(var.a_string)}"
}
output "ceil" {
  value = "${ceil(tonumber(var.a_string))}"
}
