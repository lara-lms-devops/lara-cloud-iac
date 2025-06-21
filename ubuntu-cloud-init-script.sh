echo "Updating the system"
sudo apt update -y

# TODO create a user to run the script

# TODO configure the bridge like in this link
# https://askubuntu.com/questions/1541684/ubuntu-bridge-does-not-receive-an-ip-address
# OR use Network Manager to create the bridge
# or create this manually, it seems like this just worked after restarting the system :X

echo "Installing terraform" # TODO add more echo to display the steps executed in the console
sudo apt-get install unzip -y
sudo wget https://releases.hashicorp.com/terraform/1.12.1/terraform_1.12.1_linux_amd64.zip
unzip terraform_1.12.1_linux_amd64.zip
sudo mv terraform /usr/local/bin/
sudo rm terraform_1.12.1_linux_amd64.zip LICENSE.txt

echo "Installing libvirt dependencies"
sudo apt install libvirt-daemon-system libvirt-clients qemu-kvm -y\

echo "Installing netplan and bridge-utils to create the bridge for the networks"
sudo apt install netplan.io
sudo apt install bridge-utils

# Necessary for the cloud init with the terraform
sudo apt install genisoimage

# Creating libvirt pool
# TODO understand what is the pool used for

echo "Creating 'default' libvirt pool"
sudo virsh pool-define /dev/stdin <<EOF
<pool type='dir'>
<name>default</name>
    <target>
        <path>/var/lib/libvirt/images</path>
    </target>
</pool>
EOF

sudo pool-start default
sudo pool-autostart default
sudo chown libvirt-qemu:libvirt-qemu /var/lib/libvirt/images
sudo chmod 755 /var/lib/libvirt/images

# I think the provider is already present in terraform, need to test
# echo "Downloading and installing libvirt dependency in terraform"
# mkdir -p ~/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.8.3/linux_amd64/
# wget https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.8.3/terraform-provider-libvirt_0.8.3_linux_amd64.zip -O terraform-provider-libvirt
# mv terraform-provider-libvirt ~/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.8.3/linux_amd64/terraform-provider-libvirt
# chmod +x ~/.terraform.d/plugins/registry.terraform.io/dmacvicar/libvirt/0.8.3/linux_amd64/terraform-provider-libvirt

rm noble-server-cloudimg-amd64.img
sudo wget https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
sudo cp noble-server-cloudimg-amd64.img /var/lib/libvirt/images/
sudo chown libvirt-qemu:libvirt-qemu /var/lib/libvirt/images/noble-server-cloudimg-amd64.img
sudo chmod 644 /var/lib/libvirt/images/noble-server-cloudimg-amd64.img
# Clone your original image
cp noble-server-cloudimg-amd64.img noble-server-cloudimg-amd64-20G.img

# Resize the disk (e.g., to 20 GB)
qemu-img resize noble-server-cloudimg-amd64-20G.img 20G

# TODO add the terraform call here after tests
# HAD TO DISABLE apparmor https://github.com/dmacvicar/terraform-provider-libvirt/issues/1163
# cd terraform-vm
# terraform init
# sudo terraform apply
# I used for some errors related to a lock not being acquired
# sudo terraform apply -lock=false


# Delete domain
virsh undefine test-kvm