u = node.workstation.user
home = "/home/#{u}"

directory "#{home}/.vim" do
  owner u
  group u
end

directory "#{home}/.vim/tmp" do
  owner u
  group u
end


cookbook_file "#{home}/.vimrc" do
  owner u
  group u
  mode "0600"
  source "vimrc" 
end


directory "#{home}/.vim/plugins" do
  owner u
  group u
end

remote_file "#{home}/.vim/plugins/ack.vim" do
  source "https://raw.github.com/mileszs/ack.vim/master/plugin/ack.vim"
  owner u
  group u
  mode 0644
end

package "ack-grep"

cookbook_file "#{home}/.rspec" do
  source "rspec"
  owner u
  group u
  mode 0644
end

