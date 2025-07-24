IMAGE_NAME = "cloud-image/ubuntu-24.04"
NODES = 3


Vagrant.configure("2") do |config|

    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|

        v.memory = 2048
        v.cpus = 2

    end

    (1..NODES).each do |i|

        config.vm.define "local-kube-10#{i}" do |node|

            node.vm.box = IMAGE_NAME
            node.vm.network "private_network", ip: "192.168.56.#{i + 100}"
            node.vm.hostname = "local-kube-10#{i}"

            # provision once final node is up
            if i == NODES
                node.vm.provision "ansible" do |ansible|

                    ansible.playbook = "playbooks/playbook.yml"

                    ansible.extra_vars = {

                        server_host_name: "{{ inventory_hostname }}"
                    }

                    ansible.groups = {

                        "control_plane" => ["local-kube-101"],
                        "worker" => (2..NODES).map { |n| "local-kube-10#{n}" },

                    }
                    ansible.limit = "all"

                end
            end
            
        end
    end

end

