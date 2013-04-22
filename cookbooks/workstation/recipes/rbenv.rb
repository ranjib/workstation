
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

bash "bundler" do
  code <<-EOF
echo Bundler
EOF
  user u
end

bash "rubygems" do
  code <<-EOF
echo RubyGems
EOF
  user u
end

