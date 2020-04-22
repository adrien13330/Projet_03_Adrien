#Basic Setup
sudo apt -y update
sudo apt -y upgrade

#Curl
sudo apt install -y curl

#Visual Studio Code
curl https://az764295.vo.msecnd.net/stable/ff915844119ce9485abfe8aa9076ec76b5300ddd/code_1.44.2-1587059832_amd64.deb --output /home/$USER/Downloads/code.deb
sudo dpkg -i /home/$USER/Downloads/code.deb

#VMware Workstation Player 15.5.2
#curl http://download3.vmware.com/software/player/file/VMware-Player-15.5.2-15785246.x86_64.bundle --output /home/$USER/Downloads/vmware-workstation-player
#sudo chmod +x vmware-workstation-player
#./vmware-workstation-player
#vagrant plugin install vagrant-vmware-desktop

#Vagrant Virtualbox
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian bionic contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
sudo apt update
sudo apt install -y virtualbox-6.0

#Vagrant 2.2.7
curl https://releases.hashicorp.com/vagrant/2.2.7/vagrant_2.2.7_x86_64.deb --output /home/$USER/Downloads/vagrant-2.2.7.deb
sudo dpkg -i /home/$USER/Downloads/vagrant-2.2.7.deb

#Vagrant Root Setup
mkdir vagrant_projet_3
cd vagrant_projet_3

#WWW Setup
mkdir html
cd html
echo '<!DOCTYPE html>' >> index.html  | sudo tee -a /etc/apt/sources.list
echo '<html>' >> index.html  | sudo tee -a /etc/apt/sources.list
echo '  <body>' >> index.html  | sudo tee -a /etc/apt/sources.list
echo '    <h1>Getting started with Vagrant!</h1>' >> index.html  | sudo tee -a /etc/apt/sources.list
echo '  </body>' >> index.html  | sudo tee -a /etc/apt/sources.list
echo '</html>' >> index.html  | sudo tee -a /etc/apt/sources.list
cd ..

#Vagrant Setup
vagrant init generic/debian10
vagrant box add generic/debian10

#Vagrant Plugin for box generic/debian10
vagrant plugin install vagrant-vbguest

#Vagrantfile Setup
mv Vagrantfile Vagrantfile.old
echo 'Vagrant.configure("2") do |config|' >> Vagrantfile  | sudo tee -a /etc/apt/sources.list
echo '  config.vm.box = "generic/debian10"' >> Vagrantfile  | sudo tee -a /etc/apt/sources.list
echo '  config.vm.synced_folder "", "/vagrant"' >> Vagrantfile  | sudo tee -a /etc/apt/sources.list
echo '  config.vm.provision :shell, path: "bootstrap.sh"' >> Vagrantfile  | sudo tee -a /etc/apt/sources.list
echo '  config.vm.network "forwarded_port", guest: 80, host: 4567' >> Vagrantfile  | sudo tee -a /etc/apt/sources.list
echo '  config.vm.provider "virtualbox" do |v|' >> Vagrantfile  | sudo tee -a /etc/apt/sources.list
echo '    v.memory = 4096' >> Vagrantfile  | sudo tee -a /etc/apt/sources.list
echo '  end' >> Vagrantfile  | sudo tee -a /etc/apt/sources.list
echo 'end' >> Vagrantfile  | sudo tee -a /etc/apt/sources.list

#Vagrant Bootstrap Setup
echo 'apt-get install -y apache2' >> bootstrap.sh  | sudo tee -a /etc/apt/sources.list
echo 'if ! [ -L /var/www ]; then' >> bootstrap.sh  | sudo tee -a /etc/apt/sources.list
echo '  rm -rf /var/www' >> bootstrap.sh  | sudo tee -a /etc/apt/sources.list
echo '  ln -fs /vagrant /var/www' >> bootstrap.sh  | sudo tee -a /etc/apt/sources.list
echo 'fi' >> bootstrap.sh  | sudo tee -a /etc/apt/sources.list

#Vagrant Startup
vagrant up

#Ansible Setup - Latest
echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu bionic main" | sudo tee -a /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
sudo apt update
sudo apt install ansible -y

#Docker CE Setup - Latest
sudo apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt -y update
apt-cache policy docker-ce
sudo apt install -y docker-ce
