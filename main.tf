  # TO CREATE PROD ENVIRONMENT

#WEBSERVER - EC2 INSTANCE
resource "aws_instance" "prod-web" {
ami = "ami-06a0b4e3b7eb7a300"
instance_type = var.instance_type["zone2"]
count = "${terraform.workspace == "prod" ? 1 : 0}"
key_name = var.key
tags = {
  Name = var.ec2
}
connection {
 type = "ssh"
 user = "ec2-user"
 private_key = file("C:/Users/yagya/Downloads/yagyash1.pem")
 host = aws_instance.prod-web.0.public_ip
}
provisioner "remote-exec" {
    inline = [
    		"sudo yum install podman -y",
		"sudo podman run -d -p 8080:80 --name wordpress-app-prod docker.io/wordpress"
    ]
  }
}
#DATABASE - RBS
resource "aws_db_instance" "db-prod" {
  depends_on           = [
                        aws_instance.prod-web,
  ]
  allocated_storage    = 10
  engine               = var.engine[0]
  engine_version       = var.engine_version[mysql]
  instance_class       = var.intance_class
  name                 = var.db-prod_name
  username             = var.db-prod_user
  password             = var.db-prod_passwors
  skip_final_snapshot  = true
}


# TO CREATE DEV ENVIRONMENT

resource "google_compute_address" "static" {
  name = var.compute_address
  count        = "${terraform.workspace == "dev" ? 1 : 0}"
}
resource "google_compute_firewall" "webserverrule" {
  name    = var.firewall-rule
  network = var.gcp_network
  allow {
    protocol = "tcp"
    ports    = ["80" , "8080"]
  }
  count        = "${terraform.workspace == "dev" ? 1 : 0}"
  }

resource "google_compute_instance" "dev-web" {
  name         = var.gce
  count        = "${terraform.workspace == "dev" ? 1 : 0}"
  machine_type = var.machine_type["type1"]
  zone         = var.gcp_zone[0]
  boot_disk {
      initialize_params {
      image = var.gcp_image["us-central1-a"]
    }
}
network_interface {
    network = var.gcp_network
    access_config {
      nat_ip = google_compute_address.static.0.address
    }
}
metadata = {
   ssh-keys = "${var.user}:${file(var.publickey)}"
 }
connection {
 type = "ssh"
 user = var.user
 private_key = file(var.privatekey)
 host = google_compute_address.static.0.address
}
provisioner "remote-exec" {
    inline = [
    		"sudo yum install podman -y",
		"sudo podman run -d -p 8080:80 --name wordpress-app-dev wordpress"
    ]
  }
}


#DATABASE CLoud SQL

resource "google_sql_database_instance" "db-dev" {
  name             = var.db_instance_name
  project          = var.project
  database_version = var.database_version[4]
  region           = var.gcp_region[0]
  depends_on           = [
                        google_compute_instance.dev-web[0],
  ]
  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled    = true
      authorized_networks {
  	 name = var.access
         value = google_compute_address.static.0.address
  }
  }
}
}

resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.db-dev.name
   depends_on           = [
                        google_sql_database_instance.db-dev,
  ]
}

resource "google_sql_user" "users" {
  name     = var.username
  instance = google_sql_database_instance.db-dev.name
  password = var.db_password
     depends_on           = [
                        google_sql_database_instance.db-dev,
  ]
}