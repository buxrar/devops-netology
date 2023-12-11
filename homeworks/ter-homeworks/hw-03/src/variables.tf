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

variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "yandex compute image family"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_storage_resource" {
  type = map(string)
  default = {
      name = "storage"
      platform_id = "standard-v1"
    }
  description = "yandex compute instance vars"
}

variable "vm_web_resource" {
  type = map(string)
  default = {
      name = "web"
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

variable "vm_nat" {
  type = bool
  default = true
  description = "yandex compute instance nat conf"
}

variable "vm_ssh_conf" {
  type = map(string)
  default = {
      serial = "1"
      ssh_keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzuXvGEstWnn3ZVSGYuG7tvaUY4Bz3SN8gxogxL1DAS"
    }
  description = "yandex compute instance ssh conf"
}

variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk=number, core_fraction=number }))
  default = [
    {
      vm_name    = "main"
      cpu           = 4
      ram           = 4
      disk          = 10
      core_fraction = 20
    },
    {
      vm_name    = "replica"
      cpu           = 2
      ram           = 2
      disk          = 8
      core_fraction = 5
    }
  ] 
}

variable "storage_dataset" {
  type = list(object({ name=string, size=number, zone=string, type=string, count=number }))
  default = [
    {
      id      = 1
      name    = "hdd"
      size    = 1
      zone    = "ru-central1-a"
      type    = "network-hdd"
      count   = 3
    }
  ] 
}
