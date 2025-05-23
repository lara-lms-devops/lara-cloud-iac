echo "Updating the system"
sudo apt update -y

echo "Installing terraform"
sudo apt install -y terraform

echo "Installing libvirt dependencies"
sudo apt install libvirt-daemon-system libvirt-clients qemu-kvm

# I think the provider is already present in terraform, need to test
# echo "Downloading and installing libvirt dependency in terraform"
# mkdir -p ~/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.8.3/linux_amd64/
# wget https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.8.3/terraform-provider-libvirt_0.8.3_linux_amd64.zip -O terraform-provider-libvirt
# mv terraform-provider-libvirt ~/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.8.3/linux_amd64/terraform-provider-libvirt
# chmod +x ~/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.8.3/linux_amd64/terraform-provider-libvirt

rm noble-server-cloudimg-amd64.img
sudo wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img`

# TODO add the terraform call here after tests