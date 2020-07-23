variable "public_key" {
  default = "./private/id_rsa.pub"
}

variable "private_key" {
  default = "./private/id_rsa"
}

variable "username" {
  default = "ubuntu"
}

variable "aws_secret_key" {
  default = "./private/aws-secret-key"
}

variable "aws_access_key" {
  default = "./private/aws-access-key"
}
