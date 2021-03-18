variable "app" {
  type = string
}

variable "env" {
  type = string
  validation {
    condition     = var.env == "prod" || var.env == "dev"
    error_message = "The env value must be either 'prod' or 'dev'."
  }
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "billing_account" {
  type    = string
  default = "My Billing Account"
}
