

data "template_file" "instance_userdata" {
  template = file("linux.tpl")
  vars = {
    env        = "perf"
    username   = "centos"
    ssh_public = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC62FDKK90+G1QWkOTt6o/b2W1cH8qg6YvpIVAV/n9pdQ5ggEJciq06Dn+Bv8SPp6X5EwR+BmAGcA6FbJ9hGW4HmCi+/ALoSsl894RGD5Ayd8TOj2kRGzAVwMqZT/XGkASD7EMn8x8WG39bPBG2Br+mtPqdcrbjRw3M/seu88oZ8dikoaFDVug332YcdGA9H3Oz0sMoap9VHsKuLKbmQOhHVE8n94T8YAQA/N+gFCJh6b4WlA75XqJeLPUZ8eM/7ds4ITa0CWckoSCZMHVrvizRuagB4/ay60auiSsXbNXNbLCASo6a6mDXOySRA3sv4r+ib+Kh+pxyKpqds2LS8MXT6Lk+JOKMzWkhW2uMm27By9d0rLIcxu09Ek9UeJG8V/IvITwhAadyv++daOC0Xv2i6Tbwr99pdUapzNhin4UjE9udU4WM1eoGUJb25/sc1NZhUHuPigD9z6FskTXdMUDc+itjk3Bess1rJfvsXP8MQwAEHEZ4+YSFPkWm/Xwu9XE="
  }
}