
%w{htop vim git tig gource build-essential openssl libssl-dev libxml2 libxml2-dev
   libreadline-dev libxslt1-dev screen tmux}.each do |pkg|
  package pkg
end

u = node.workstation.user
home = node.workstation.home

Chef::Log.info("Setting up workstation for user '#{u}'")

user u

cookbook_file "#{home}/.gitconfig" do
  source 'gitconfig'
  owner u
  group u
  mode "0644"
end

cookbook_file "#{home}/.gitignore" do
  source 'gitignore'
  owner u
  group u
  mode "0644"
end

cookbook_file "#{home}/.bashrc" do
  source 'bashrc'
  owner u
  group u
  mode "0644"
end

directory "#{home}/.dir_colors" do
  owner u
  group u
end

template '/etc/sudoers' do
 mode '0440'
end


