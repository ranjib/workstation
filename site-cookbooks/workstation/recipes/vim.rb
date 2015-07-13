u = node.workstation.user
home = "/home/#{u}"

package 'ack-grep'

%w(.vim .vim/tmp .vim/plugin .vim/autoload .vim/bundle).each do |d|
  directory "#{home}/#{d}" do
    owner u
    group u
  end
end

remote_file  "#{home}/.vim/autoload/pathogen.vim" do
  source 'https://tpo.pe/pathogen.vim'
  owner u
  group u
  mode "0600"
end

cookbook_file "#{home}/.vimrc" do
  owner u
  group u
  mode "0600"
  source "vimrc" 
end

git "#{home}/.vim/bundle/ack.vim" do
  repository 'https://github.com/mileszs/ack.vim.git'
  action :sync
  user u
  group u
  mode 0644
end

git "#{home}/.vim/bundle/vim-go" do
  repository 'https://github.com/fatih/vim-go.git'
  action :sync
  user  u
  group u
end
