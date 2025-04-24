Vagrant.configure("2") do |config|
  # Use Ubuntu Jammy (22.04 LTS) as the base box
  config.vm.box = "ubuntu/jammy64"

  # Configure VirtualBox provider
  config.vm.provider "virtualbox" do |vb|
    vb.memory = 4096
    vb.cpus = 2
  end

  # Forward port 80 from guest to host
  config.vm.network "forwarded_port", guest: 80, host: 80, host_ip: "127.0.0.1"

  # Sync the current directory to /home/vagrant/
  config.vm.synced_folder ".", "/home/vagrant/"

  # Provision the VM with Docker and run the container
  config.vm.provision "shell", inline: <<-SHELL
    # Update package lists
    sudo apt-get update -y

    # Install prerequisites
    sudo apt-get install -y ca-certificates curl

    # Remove any conflicting Docker packages
    sudo apt-get remove -y docker.io docker-doc docker-compose podman-docker containerd runc || true

    # Install Docker using the official convenience script
    curl -fsSL https://get.docker.com | sh

    # Add vagrant user to docker group
    sudo usermod -aG docker vagrant

    # Build and run the Docker container
    cd /home/vagrant/app
    docker build -t my-app -f Dockerfile .
    docker run -d -p 80:80 --name my-app-container my-app
  SHELL
end