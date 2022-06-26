# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2010" # Base box for our lab

  # Synced folder. Needed for ansible_local
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "pubkey", type: "file", source: "~/.ssh/id_rsa.pub", destination: "/tmp/host-id_rsa.pub"
  config.vm.provision "pre-shell", type: "shell", path: "provision/shell/pre-shell.sh"


  # Ansible provision config
  # Ansible will be run from the guest, as in inception.
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "provision/ansible/playbook.yml"
    ansible.verbose = "v"
  end
end
