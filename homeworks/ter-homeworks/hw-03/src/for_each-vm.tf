
resource "yandex_compute_instance" "db" {
  for_each    = {for vdb in var.each_vm: vdb.vm_name => vdb}
  name        = each.value.vm_name
  hostname    = each.value.vm_name
  description = each.value.vm_name
  folder_id   = var.folder_id
  zone        = var.default_zone
  platform_id = var.vm_web_resource.platform_id

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk
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