variable "location" {
  type    = string
  default = "westeurope"
}
variable "prefix" {
  type    = string
  default = "demo"
}

variable "ssh-source-address" {
  type    = string
  default = "*"
}

variable "ip-config" {
  default = [
    {
      name       = "instance1-ip1"
      allocation = "Dynamic" 
      primary    = true
    },
    {
      name       = "instance1-ip2"
      allocation = "Dynamic" 
      primary    = false
    },
  ]
}

variable "project_tags" {
  type          = map(string)
  default       = {
    component   = "Frontend"
    environment = "Production"
  }
}

