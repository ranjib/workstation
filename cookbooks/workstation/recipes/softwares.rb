
# Taken from jtimberman's recipe

remote_file "#{Chef::Config[:file_cache_path]}/vagrant.deb" do
  source node['vagrant']['url']
  checksum node['vagrant']['checksum']
  notifies :install, "dpkg_package[vagrant]", :immediately
end

dpkg_package "vagrant" do
  source "#{Chef::Config[:file_cache_path]}/vagrant.deb"
end

execute "vb_repo_key" do
  command "wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -"
  not_if "apt-key  list |grep VirtualBox"
end 

cookbook_file '/etc/apt/sources.list.d/virtualbox.list' do
  mode "0644"
  notifies :run, "execute[apt_update]", :immediately
end

package "virtualbox-4.2"

execute "vb_repo_key" do
  command "wget -q https://www.hipchat.com/keys/hipchat-linux.key -O- | sudo apt-key add -"
  not_if "apt-key  list |grep hipchat"
end 

cookbook_file '/etc/apt/sources.list.d/hipchat.list' do
  mode "0644"
  notifies :run, "execute[apt_update]", :immediately
end

execute "apt_update" do
  command "apt-get update"
  action :nothing
end

package "hipchat"

 
