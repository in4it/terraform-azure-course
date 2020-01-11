variable "to_encode" {
    default = "encode me"
}

output "base64encode" {
  value = "${base64encode(var.to_encode)}"
}

variable "to_decode" {
    default = "ZW5jb2RlIG1l"
}

output "base64decode" {
  value = "${base64decode(var.to_decode)}"
}