variable "image_source" {
    description = "The Ubuntu Noble LTS Cloud Image stored in the host directory"
    default = "../noble-server-cloudimg-amd64.img"
    type = string
}

variable "image_format" {
    description = "QCow2 UEFI/GPT Bootable disk image"
    default = "qcow2"
    type = string
}

variable "memory_size" {
    description = "Total memory for the VM in MiB"
    default = "2048"
    type = string
}

variable "cpu_cores" {
    description = "CPU vcores"
    default = 2
    type = number
}

