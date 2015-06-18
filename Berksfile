# -*- ft:ruby -*-

source 'https://api.berkshelf.com'

Dir['site_cookbooks_path/**'].sort.each do |cookbook_path|
  cookbook File.basename(cookbook_path), path: cookbook_path
end
