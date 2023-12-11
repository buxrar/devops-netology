resource "yandex_compute_disk" "storage_disks" {
  name       = format("%s-%01d", var.storage_dataset[0].name, count.index + 1)
  type       = var.storage_dataset[0].type
  zone       = var.storage_dataset[0].zone
  size       = var.storage_dataset[0].size
  count      = var.storage_dataset[0].count
}

resource "yandex_compute_instance" "storage" {
  name        = var.vm_storage_resource.name
  hostname    = var.vm_storage_resource.name
  description = var.vm_storage_resource.name
  folder_id   = var.folder_id
  zone        = var.default_zone
  platform_id = var.vm_storage_resource.platform_id

  resources {
    cores         = var.vm_default_resources.web_resources.cores
    memory        = var.vm_default_resources.web_resources.memory
    core_fraction = var.vm_default_resources.web_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disks.*.id
    content {
        disk_id = secondary_disk.value
    }
}

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.vm_nat
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    serial-port-enable = var.vm_ssh_conf.serial
    ssh-keys           = var.vm_ssh_conf.ssh_keys
  }

}