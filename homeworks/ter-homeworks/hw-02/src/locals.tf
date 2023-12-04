locals { 
    platform_name = "netology-develop-platform"
    node01 = "web"
    node01_name = "${local.platform_name}-${local.node01}"
    node02 = "db"
    node02_name = "${local.platform_name}-${local.node02}"
}