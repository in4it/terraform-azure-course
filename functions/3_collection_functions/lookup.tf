variable "key" {
  default = "one"
}

variable "key-default" {
  default = "two"
}

variable "map" {
  type = map

  default = {
    "one" = "1",
    "two" = "2"
  }
}

output "lookup_output" {
  value = "${lookup(var.map, "two")}"
}

output "lookup_output_var" {
  value = "${lookup(var.map,var.key,var.key-default)}"
}