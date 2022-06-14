variable "project_id" {
  type = string
  default = ""
  description = "GCP project id"
}

variable "name" {
  type = string
  default = ""
  description = "display name for the reserved IP"
}

variable "purpose" {
  type = string
  default = ""
  description = "purpose for reserving the IP"
}

variable "address_type" {
  type = string
  default = ""
  description = "internal or external IP"
}

variable "prefix_length" {
  type = string
  default = "subnet mask of the range"
}

variable "vpc_network" {
  type = string
  default = "your VPC network"
}
