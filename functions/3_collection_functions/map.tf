variable "value" {
  default = "training"
}

output "map_output" {
  value = "${map("key",var.value)}"
}