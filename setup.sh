
apt-get install curl
curl -L https://www.opscode.com/chef/install.sh | sudo bash
sudo chef-solo -c configs/solo.rb -j configs/dna.json --force-logger
