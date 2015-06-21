u = node.workstation.user
home = node.workstation.home

directory "#{home}/workspace" do
  recursive true
  owner u
  group u
end

directory "#{home}/workspace/foss" do
  recursive true
  owner u
  group u
end

directory "#{home}/workspace/foss/cc" do
  recursive true
  owner u
  group u
end
directory "#{home}/workspace/foss/cc" do
  recursive true
  owner u
  group u
end

git "#{home}/workspace/foss/chef" do
  repository "https://github.com/opscode/chef.git"
  user u
end

git "#{home}/workspace/foss/chefspec" do
  repository "https://github.com/acrmp/chefspec.git"
  user u
end

