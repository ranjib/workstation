# -*- ft:ruby -*-

source 'https://api.berkshelf.com'

cookbook 'goatos', github: 'goatos/goatos'
cookbook 'go_cd', github: 'goatos/go_cd'
cookbook 'xml_file', github: 'goatos/xml_file'

Dir['site-cookbooks/**'].sort.each do |cookbook_path|
  cookbook File.basename(cookbook_path), path: cookbook_path
end
