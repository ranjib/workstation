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


coobook_file "#{home}/.vimrc" do
  owner u
  group u
  mode "0600"
  source "vimrc" 
end


directory "#{home}/.vim/plugins" do
  owner u
  group u
end




