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

remote_file "#{home}/.vim/plugin/ack.vim" do
  source "https://raw.github.com/mileszs/ack.vim/master/plugin/ack.vim"
  owner u
  group u
  mode 0644
end

cookbook_file "#{home}/.rspec" do
  source "rspec"
  owner u
  group u
  mode 0644
end
