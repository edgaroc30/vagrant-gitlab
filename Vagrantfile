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
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "70"]
  end

  # Port mapping

  # GITLAB
  config.vm.network "forwarded_port", guest: 443, host: 443 #GITLAB
  config.vm.network "forwarded_port", guest: 80, host: 80 #GITLAB
  # config.vm.network "forwarded_port", guest: 23, host: 22 #GITLAB

  # SQL Containers
  config.vm.network "forwarded_port", guest: 1433, host: 1433 #SQLDEV
  config.vm.network "forwarded_port", guest: 1443, host: 1443 #SQLQA
  config.vm.network "forwarded_port", guest: 1453, host: 1453 #SQLPRD

  config.vm.network "public_network", type: "dhcp"

  # Gitlab docker provision with a 4 GB RAM limit + 1 SQL Containers with 2 GB RAM Limit

  config.vm.provision "docker" do |d|
  #  d.run "gitlab/gitlab-ce:latest",
  #    # cmd: "bash -l",
  #    args: "--detach  \
  #    --hostname gitlab.git.com \
  #    --publish 443:443 \
  #    --publish 80:80 \
  #    --publish 23:22 \
  #    --name gitlab \
  #    --restart always \
  #    --volume /srv/gitlab/config:/etc/gitlab \
  #    --volume /srv/gitlab/logs:/var/log/gitlab \
  #    --volume /srv/gitlab/data:/var/opt/gitlab \
  #    --memory='4GB'"


      d.pull_images "mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu"

      d.run "sqlserver-prd",
      # cmd: "bash -l",
      args: "--detach  \
      --publish 1453:1433 \
      --name sqlprd \
      --restart always \
      -e 'ACCEPT_EULA=Y' \
      -e 'SA_PASSWORD=LWv9QWhPEk6A6nyv' \
      -v /srv/sql/prd:/var/opt/mssql \
      --memory='2GB'",
      image: "mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu"


      d.run "sqlserver-qa",
      # cmd: "bash -l",
      args: "--detach  \
      --publish 1443:1433 \
      --name sqlqa \
      --restart always \
      -e 'ACCEPT_EULA=Y' \
      -e 'SA_PASSWORD=LWv9QWhPEk6A6nyv' \
      -v /srv/sql/qa:/var/opt/mssql \
      --memory='2GB'",
      image: "mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu"

      # SQLDEV Server
      d.run "sqlserver-dev",
      # cmd: "bash -l",
      args: "--detach  \
      --publish 1433:1433 \
      --name sqldev \
      --restart always \
      -e 'ACCEPT_EULA=Y' \
      -e 'SA_PASSWORD=LWv9QWhPEk6A6nyv' \
      -v /srv/sql/dev:/var/opt/mssql \
      --memory='2GB'",
      image: "mcr.microsoft.com/mssql/server:2019-CTP3.2-ubuntu"
      
  end

  # sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=LWv9QWhPEk6A6nyv' -p 1433:1433 --detach --memory='2GB' -v /srv/sql/prd:/var/opt/mssql -d mcr.microsoft.com/mssql/server:2017-latest 
  config.vm.provision "file", source: "./provision/backup.bak", destination: "/home/vagrant"

  config.vm.provision :shell, path: "./provision/bootstrap.sh"
#  config.vm.provision "file", source: "./provision/backup.bak", destination: "/srv/sql/prd"
#  config.vm.provision "file", source: "./provision/backup.bak", destination: "/srv/sql/qa"
#  config.vm.provision "file", source: "./provision/backup.bak", destination: "/srv/sql/dev"

end 