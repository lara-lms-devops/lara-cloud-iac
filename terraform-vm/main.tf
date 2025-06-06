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

# resource "libvirt_volume" "ubntu_base_volume" {
#     name = "ubuntu.${var.image_format}"
#     pool = "default"
#     source = var.image_source
#     format = var.image_format
# }

resource "libvirt_volume" "lara_storage_volume" {
    name = "lara-storage-volume.${var.image_format}"
    pool = "default"
    source = var.image_source
    format = var.image_format
}

resource "libvirt_volume" "lara_k3s_volume" {
    name = "lara-k3s-volume.${var.image_format}"
    pool = "default"
    source = var.image_source
    format = var.image_format
}

# resource "libvirt_volume" "lara_storage_disk" {
#     name = "lara-storage-volume.raw"
#     pool = "default"
#     format = "raw"
#     size   = 10737418240  # 10 GB in bytes
# } # TODO attach the disk inside the VM using clound init

# TODO shell commands that chat gpt displayed to attach the disks
# # List new disk (likely /dev/vdb if it's the 2nd disk)
# lsblk

# # Format it (example: ext4)
# sudo mkfs.ext4 /dev/vdb

# # Mount it
# sudo mkdir /mnt/storage
# sudo mount /dev/vdb /mnt/storage

# # Make it permanent
# echo '/dev/vdb /mnt/storage ext4 defaults 0 0' | sudo tee -a /etc/fstab

# resource "libvirt_volume" "lara_k3s_os_volume" {
#     name = "lara-k3s-os-volume.${var.image_format}"
#     pool = "default"
#     source = var.image_source
#     format = var.image_format
# }

# resource "libvirt_volume" "kernel" {
#     name = "kernel"
#     pool = "default"
#     source = var.image_source
#     format = "raw"
# }

resource "libvirt_network" "lara_network" { # TODO check if I need to add a bridge to the ubuntu and add it through command line and yaml file (Netplan)
    name = "lara_network"
    mode = "bridge"
    # domain = "lara.local" # Not used in bridge mode
    autostart = true
    bridge = "br0"
    # TODO understand more about networks
    # https://wiki.libvirt.org/VirtualNetworking.html
    # study ethernet bridge
    # https://usercomp.com/news/1044453/configuring-kvm-vms-with-public-ip-addresses-and-vlans
    # https://www.linuxquestions.org/questions/linux-virtualization-and-cloud-90/qemu-kvm-outside-the-lan-how-to-access-through-the-internet-4175490850/
    # https://superuser.com/questions/1474254/firewall-cmd-add-forward-port-dont-work

    # TODO understand DNS and how I should configure it
    # https://www.youtube.com/watch?v=qhiyTH5B21A
    # https://www.youtube.com/watch?v=ZYsjMEISR6E
    # https://www.youtube.com/watch?v=W5xHec3_Tts
    # https://www.youtube.com/watch?v=NPFbYpb0I7w
    # https://www.youtube.com/watch?v=LBsZYPUUGuM
}

# resource "libvirt_domain" "guest" {
#     name = "test-kvm"
#     memory = var.memory_size
#     vcpu = var.cpu_cores

#     # SHOULD BE REMOVE WHEN RUNNING IN BARE METAL, THIS IS ONLY USED TO ALLOW THE CREATION OF VM IN VIRTUAL BOX GUEST
#     type = "qemu"

#     disk {
#         volume_id = libvirt_volume.volumes.id
#     }

#     network_interface {
#         network_name = "lara_network"
#     }
# }

resource "libvirt_cloudinit_disk" "nginx_cloudinit" {
    name = "cloudinit-nginx.iso"
    user_data = file("${path.module}/cloudinit/nginx-test-cloudinit.yaml")
}

resource "libvirt_domain" "lara_storage_vm" {
    name = "lara-storage-vm"
    // TODO configure memory and cpu better
    memory = var.memory_size
    vcpu = var.cpu_cores

    autostart = true
    # TODO add cloud init, need to create the cloud init file and libvirt_cloudinit block
    cloudinit = libvirt_cloudinit_disk.nginx_cloudinit.id # ONLY FOR TESTING

    network_interface {
        network_id = libvirt_network.lara_network.id
        addresses = [ "10.0.2.16" ] # TODO move this to the variable file
        hostname = "lara-storage-host" # TODO move to the variable file and see if it is possible to put in a block all configs
        mac = "AA:BB:CC:11:22:22"
    }

    disk {
        volume_id = libvirt_volume.lara_storage_volume.id
    }

    # SHOULD BE REMOVE WHEN RUNNING IN BARE METAL, THIS IS ONLY USED TO ALLOW THE CREATION OF VM IN VIRTUAL BOX GUEST
    type = "qemu"
}


resource "libvirt_domain" "lara_k3s_vm" {
    name = "lara-k3s-vm"
    // TODO configure memory and cpu better
    memory = var.memory_size
    vcpu = var.cpu_cores

    autostart = true
    # TODO add cloud init, need to create the cloud init file and libvirt_cloudinit block
    cloudinit = libvirt_cloudinit_disk.nginx_cloudinit.id # ONLY FOR TESTING

    network_interface {
        network_id = libvirt_network.lara_network.id
        addresses = [ "10.0.2.17" ] # TODO move this to the variable file
        hostname = "lara-k3s-host" # TODO move to the variable file and see if it is possible to put in a block all configs
        mac = "AA:BB:CC:11:22:23"
    }

    disk {
        volume_id = libvirt_volume.lara_k3s_volume.id
    }

    # SHOULD BE REMOVE WHEN RUNNING IN BARE METAL, THIS IS ONLY USED TO ALLOW THE CREATION OF VM IN VIRTUAL BOX GUEST
    type = "qemu"
}

# TODOS
# * Create the two VMs in this files, as two libvirt_domain resources
# [] Create the terraform project for the K3S VM
# [] Create cloud init that installs and configure K3S
# [] Create the terraform project for the Storage VM
# [] Create cloud init that installs and configure MySQL
# [] Add some type of identity provider to only allow the K3S deploy for allowed users
# [] Understand why a bunch of files where created in the user's path

# TODOS top priority
# [X] Understand why the VM don't have IP and the bridge break the ssh for me
# A. It was missing the mac address in the domain's network_interface block and some time for the VM truly start
# [X] Understand why nginx is failing in the VM
# A. It is working now and I don't know why


# Resources
# https://docs.cloud-init.io/en/latest/tutorial/qemu.html#tutorial-qemu
# https://docs.cloud-init.io/en/latest/tutorial/lxd.html#tutorial-lxd
# https://help.ubuntu.com/community/CloudInit
# https://docs.k3s.io/installation/configuration
