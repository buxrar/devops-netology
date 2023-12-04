resource "yandex_compute_instance" "manager" {
  count = 1

  name        = format("manager-%02d", count.index + 1)
  hostname    = format("manager-%02d", count.index + 1)
  description = format("manager-%02d", count.index + 1)
  folder_id   = var.folder_id
  zone        = var.zone
  platform_id = "standard-v2"

  allow_stopping_for_update = true

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8htefubdfrgrdgh6dj"
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = var.subnet
    nat                = true
  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    user-data = data.template_file.instance_userdata.rendered
  }
}

resource "yandex_compute_instance" "worker" {
  count = 3

  name        = format("worker-%02d", count.index + 1)
  hostname    = format("worker-%02d", count.index + 1)
  description = format("worker-%02d", count.index + 1)
  folder_id   = var.folder_id
  zone        = var.zone
  platform_id = "standard-v2"

  allow_stopping_for_update = true

  resources {
    cores         = 2
    core_fraction = 20
    memory        = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8htefubdfrgrdgh6dj"
      size     = 10
      type     = "network-hdd"
    }
  }

  network_interface {
    subnet_id          = var.subnet
    nat                = true
  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    user-data = data.template_file.instance_userdata.rendered
  }
}