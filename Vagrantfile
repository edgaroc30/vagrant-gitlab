Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
  # config.disksize.size = '50GB'
  config.vm.provider "virtualbox" do |vb|
    vb.name = "gitlab"
    # Limit the memory for this VM
    vb.memory = "8192"
    # Limit the number of CPUs available for this VM
    vb.customize ["modifyvm", :id, "--cpus", 2]
    # Limit the CPU usage for this VM in the host
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end

  # Port mapping

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 22, host: 22
  config.vm.network "forwarded_port", guest: 443, host: 443
  config.vm.network "forwarded_port", guest: 81, host: 8081
  config.vm.network "forwarded_port", guest: 23, host: 23
  config.vm.network "forwarded_port", guest: 444, host: 444
  config.vm.network "public_network", type: "dhcp"

  # Gitlab docker provision with a 4 GB RAM limit

  config.vm.provision "docker" do |d|
    d.run "gitlab/gitlab-ce:latest",
      # cmd: "bash -l",
      args: "--detach  \
      --hostname gitlab.git.com \
      --publish 444:443 \
      --publish 8081:80 \
      --publish 24:22 \
      --name gitlab \
      --restart always \
      --volume /srv/gitlab/config:/etc/gitlab \
      --volume /srv/gitlab/logs:/var/log/gitlab \
      --volume /srv/gitlab/data:/var/opt/gitlab \
      --memory='4GB'"
  end
  # Copy apache configuration files from the host to the vm
  # config.vm.provision "file", source: "/srv/apache/", destination: " /srv/apache/"
  config.vm.provision :shell, path: "./provision/bootstrap.sh"

end