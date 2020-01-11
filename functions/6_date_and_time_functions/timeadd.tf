variable "date" {
  default = "2020-01-10T00:00:00Z"
}

variable "add" {
  default = "12h"
}

output "timeadd" {
  value = "${timeadd(var.date, var.add)}"
}