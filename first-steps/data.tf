data "http" "myip" {
  url = "https://ifconfig.me/"

  lifecycle {
    postcondition {
      condition     = contains([200], self.status_code)
      error_message = "Status code invalid: ${self.status_code}"
    }
  }
}
