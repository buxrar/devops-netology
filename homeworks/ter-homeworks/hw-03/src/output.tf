output "inventary" {
  value = flatten ([
    [
      for web_instance in yandex_compute_instance.web:
      {
            name = web_instance.name
            id   = web_instance.id
            fqdn = web_instance.fqdn
      }
    ],
    [
      for db_instance in yandex_compute_instance.db:
      {
            name = db_instance.name
            id   = db_instance.id
            fqdn = db_instance.fqdn
      }
    ],
    [
      for disk_instance in [yandex_compute_instance.storage]:
      {
            name = disk_instance.name
            id   = disk_instance.id
            fqdn = disk_instance.fqdn
      }
    ]
  ])
}