# IAM Credentials
variable "AWS_ACCESS_KEY_ID" {
  type    = string
}

variable "AWS_SECRET_ACCESS_KEY" {
  type    = string
}

# togglable prefix
variable "prefix" {
  type    = string
  default = "btc-prod"
}
