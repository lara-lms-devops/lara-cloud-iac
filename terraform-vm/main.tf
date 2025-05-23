terraform {
    required_providers {
        libvirt = {
            source = "dmacvicar/libvirt"
            version = "0.8.3"
        }
    }
}

provider "libvirt" {
    uri = "qemu:///system"
}

resource "libvirt_volume" "volumes" {
    name = "test-kvm.${var.image_format}"
    pool = "default"
    source = var.image_source
    format = var.image_format
}

resource "libvirt_domain" "guest" {
    name = "test-kvm"
    memory = var.memory_size
    vcpu = var.cpu_cores

    disk {
        volume_id = libvirt_volume.volumes.id
    }

    network_interface {
        network_name = "default"
    }
}