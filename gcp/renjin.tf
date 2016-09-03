// Configure the Google Cloud provider
provider "google" {
  project     = "renjin-perf-testing"
  region      = "europe-west1-b"
}

resource "google_compute_instance" "opencpu-4" {
  name         = "opencpu-4"
  machine_type = "n1-standard-4"
  zone         = "europe-west1-b"
 
  tags = [ "http-server" ]
 
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
    script = "gcp/install-opencpu.sh"
    connection {
      user = "ubuntu"
    }
  }
}

resource "google_compute_instance" "renjin-4" {
  name         = "renjin-4"
  machine_type = "n1-standard-4"
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
