# -*- ft:ruby -*-

source 'https://api.berkshelf.com'

cookbook 'goatos', github: 'goatos/goatos'
cookbook 'go_cd', github: 'goatos/go_cd'

Dir['site-cookbooks/**'].sort.each do |cookbook_path|
  cookbook File.basename(cookbook_path), path: cookbook_path
end
