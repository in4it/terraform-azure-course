output "file" {
  value = "${file("${path.module}/file.txt")}"
}

output "fileexists" {
  value = "${fileexists("${path.module}/file.txt")}"
}