variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "project" {
  description = "The project naem to use for unique resource naming"
  default     = "explore-terraform"
  type        = string
}

variable "principal_arns" {
  description = "A list of principal"
  default     = null
  type        = list(string)
}


