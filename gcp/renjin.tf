// Configure the Google Cloud provider

variable "machine_type" {
  default = "n1-standard-4"
}

provider "google" {
  project     = "renjin-perf-testing"
  region      = "europe-west1-b"
}

#resource "google_compute_instance" "opencpu" {
#  name         = "opencpu"
#  machine_type = "${var.machine_type}"
#  zone         = "europe-west1-b"
# 
#  tags = [ "http-server" ]
# 
#  disk {
#    image = "ubuntu-os-cloud/ubuntu-1604-lts"
#  }
# 
#  network_interface {
#    network = "default"
#    access_config {
#      // Ephemeral IP
#    }
#  }
#  
#  provisioner "remote-exec" {
#    script = "gcp/install-opencpu.sh"
#    connection {
#      user = "ubuntu"
#    }
#  }
#}

resource "google_compute_instance" "renjin" {
  name         = "renjin"
  machine_type = "${var.machine_type}"
  zone         = "europe-west1-b"

  tags = ["http-server"]

  disk {
    image = "ubuntu-os-cloud/ubuntu-1604-lts"
  }
  
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
  
  provisioner "remote-exec" {
    script = "gcp/install-renjin.sh"
    connection {
      user = "ubuntu"
    }
  }
}


#output "opencpu_ip" {
#  value = "${google_compute_instance.opencpu.network_interface.0.access_config.0.assigned_nat_ip}"
#}

output "renjin_ip" {
  value = "${google_compute_instance.renjin.network_interface.0.access_config.0.assigned_nat_ip}"
}

