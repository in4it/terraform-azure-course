variable "value" {
  default = "training"
}

output "map_output" {
  value = tomap({
    "key" = var.value
  })
}
