
sudo apt-get install curl

if [ ! -f /usr/bin/chef-solo ] 
then
  curl -L https://www.opscode.com/chef/install.sh | sudo bash
fi

sudo chef-solo -c configs/solo.rb -j configs/dna.json --force-logger

