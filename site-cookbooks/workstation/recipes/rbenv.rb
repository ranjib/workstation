
u = node.workstation.user
home= node.workstation.home

git "#{home}/.rbenv" do
  repository "https://github.com/sstephenson/rbenv.git"
  user u
end

directory "#{home}/.rbenv/plugins" do
  recursive true
  owner u
end

git "#{home}/.rbenv/plugins/ruby-build" do
  repository "https://github.com/sstephenson/ruby-build.git"
  user u
end

bash "ruby_2.2.2" do
  code <<-EOF
    .rbenv/bin/rbenv install 2.2.2
  EOF
  cwd home
  user u
  creates "#{home}/.rbenv/versions/2.2.2/bin/ruby"
end

cookbook_file "#{home}/.irbrc" do
  source 'irbrc'
  owner u
  group u
  mode '0644'
end
