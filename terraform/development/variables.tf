variable "env" {
  type = string
  validation {
    condition     = var.env == "prod" || var.env == "dev"
    error_message = "The env value must be either 'prod' or 'dev'."
  }
}

variable "app" {
  type = string
}

variable "zone" {
  type    = string
  default = "us-central1-c"
}

variable "billing_account" {
  type    = string
  default = "My Billing Account"
}

variable "project_version" {
  type    = number
  default = 1
}
