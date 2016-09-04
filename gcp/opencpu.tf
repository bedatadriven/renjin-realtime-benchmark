resource "google_compute_instance" "opencpu" {
  name         = "opencpu"
  machine_type = "${var.machine_type}"
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
  
  # Copies our fraudscore package to the server
  provisioner "file" {
    source = "application/fraudscore_1.2.tar.gz"
    destination = "/tmp/fraudscore_1.2.tar.gz"
    connection {
      user = "ubuntu"
    }
  } 
  
  # Copy the configuration overrides to a temp folder
    provisioner "file" {
    source = "gcp/opencpu.conf"
    destination = "/tmp/opencpu.conf"
    connection {
      user = "ubuntu"
    }
  } 

  provisioner "remote-exec" {
    script = "gcp/install-opencpu.sh"
    connection {
      user = "ubuntu"
    }
  }
}


output "opencpu_ip" {
  value = "${google_compute_instance.opencpu.network_interface.0.access_config.0.assigned_nat_ip}"
}


