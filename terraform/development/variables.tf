variable "environment" {
  type = string
  validation {
    condition     = var.environment == "prod" || var.environment == "dev"
    error_message = "The environment value must be either 'prod' or 'dev'."
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
