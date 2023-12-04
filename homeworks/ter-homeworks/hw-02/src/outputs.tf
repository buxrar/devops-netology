output "external_ip" {
  value = {
    netology-develop-platform-web = yandex_compute_instance.platform.network_interface.0.nat_ip_address
    netology-develop-platform-db = yandex_compute_instance.db.network_interface.0.nat_ip_address
  }
}
