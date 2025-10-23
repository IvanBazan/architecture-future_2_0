terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}

data "yandex_vpc_network" "default" {
  name = "default"
}

data "yandex_vpc_subnet" "default_subnet" {
  name = "default-${var.yc_zone}"
}

resource "yandex_mdb_postgresql_cluster" "finance_oltp" {
  name        = "finance-oltp-${var.environment}"
  environment = var.environment == "production" ? "PRODUCTION" : "PRESTABLE"
  network_id  = data.yandex_vpc_network.default.id

  config {
    version = 14
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = var.environment == "production" ? var.db_prod_disk_size : var.db_disk_size
    }
  }

  host {
    zone      = var.yc_zone
    subnet_id = data.yandex_vpc_subnet.default_subnet.id
  }
}

resource "yandex_mdb_postgresql_user" "finance_admin" {
  cluster_id = yandex_mdb_postgresql_cluster.finance_oltp.id
  name       = var.db_username
  password   = var.db_password
}

resource "yandex_mdb_postgresql_database" "finance_oltp_db" {
  cluster_id = yandex_mdb_postgresql_cluster.finance_oltp.id
  name       = var.db_name
  owner      = var.db_username

  depends_on = [yandex_mdb_postgresql_user.finance_admin]
}

