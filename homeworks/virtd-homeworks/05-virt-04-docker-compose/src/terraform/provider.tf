terraform {
  required_providers {
    yandex = {
      source  = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
      version = "~> 0.72"
    }
  }
}
provider "yandex" {
    cloud_id = "b1g1ptkqd96nl8peatpn"
    folder_id = var.folder_id
    zone = var.zone
}