data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}
resource "yandex_compute_instance" "web" {
  count = 2

  name        = format("%s-%01d", var.vm_web_resource.name, count.index + 1)
  hostname    = format("%s-%01d", var.vm_web_resource.name, count.index + 1)
  description = format("%s-%01d", var.vm_web_resource.name, count.index + 1)
  folder_id   = var.folder_id
  zone        = var.default_zone
  platform_id = var.vm_web_resource.platform_id

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