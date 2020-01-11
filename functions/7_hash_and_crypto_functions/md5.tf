variable "md5string" {
  default = "MD5 all this information please!"
}

output "md5" {
  value = "${md5(var.md5string)}"
}