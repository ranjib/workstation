
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

bash "ruby_1.9.3" do
  code <<-EOF
    .rbenv/bin/rbenv install 1.9.3-p194
  EOF
  cwd home
  user u
  creates "#{home}/.rbenv/versions/1.9.3-p194/bin/ruby"
end

bash "ruby_2.0.0" do
  code <<-EOF
    .rbenv/bin/rbenv install 2.0.0-p0
  EOF
  cwd home
  user u
  creates "#{home}/.rbenv/versions/2.0.0-p0/bin/ruby"
end

gem_bin = "#{home}/.rbenv/versions/1.9.3-p194/bin/gem"
%w{irbtools pry bundler chef}.each do |g|
  bash g do
    code "#{gem_bin} install #{g} --no-ri --no-rdoc"
    user u
    cwd home
    environment('RBENV_ROOT'=>"#{home}/.rbenv/versions/1.9.3-p194")
    not_if "#{gem_bin} list|grep #{g}"
  end
end

cookbook_file "#{home}/.irbrc" do
  source 'irbrc'
  owner u
  group u
  mode '0644'
end
