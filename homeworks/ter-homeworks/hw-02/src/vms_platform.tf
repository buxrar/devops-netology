variable "vm_db_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "yandex compute image family"
}

variable "vm_db_resource" {
  type = map
  default = {
      name = "netology-develop-platform-db"
      platform_id = "standard-v1"
      cores = 2
      memory = 2
      core_fraction = 20
    }
  description = "yandex compute instance vars"
}
