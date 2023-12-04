###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzuXvGEstWnn3ZVSGYuG7tvaUY4Bz3SN8gxogxL1DAS"
  description = "ssh-keygen -t ed25519"
}

###custom vars

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex compute image family"
}

variable "vm_web_resource" {
  type = map(string)
  default = {
      name = "netology-develop-platform-web"
      platform_id = "standard-v1"
    }
  description = "yandex compute instance vars"
}

variable "vm_default_resources" {
  type = map(map(number))
  default = {
      web_resources = {
        cores = 2
        memory = 1
        core_fraction = 5
      }
      db_resources = {
        cores = 2
        memory = 2
        core_fraction = 20
      }
    }
  description = "yandex compute instance resources"
}

variable "vm_ssh_conf" {
  type = map(string)
  default = {
      serial = "1"
      ssh_keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzuXvGEstWnn3ZVSGYuG7tvaUY4Bz3SN8gxogxL1DAS"
    }
  description = "yandex compute instance ssh conf"
}

variable "vm_nat" {
  type = bool
  default = true
  description = "yandex compute instance nat conf"
}