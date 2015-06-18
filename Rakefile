require 'foodcritic'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require_relative 'lib/workstation/shell_out'
require_relative 'lib/workstation/version'
require 'fileutils'
require 'berkshelf'
require 'berkshelf/berksfile'

extend Workstation::ShellOut
package_name = 'workstation-cookbooks'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = %w()
end

desc 'rubocop compliancy checks'
RuboCop::RakeTask.new(:rubocop) do |t|
  t.patterns = %w(
    Rakefile
    Berksfile
    Gemfile
    site-cookbooks/**/*.rb
  )
  t.fail_on_error = true
end

desc 'Vendorize all cookbooks using berks'
task 'vendor' do
  vendor_path = File.expand_path('../workstation-cookbooks', __FILE__)
  FileUtils.rm_rf(vendor_path)
  berksfile = Berkshelf::Berksfile.from_file('Berksfile')
  berksfile.vendor(vendor_path)
end

task 'package' do
  command = 'bundle exec fpm -s dir -t deb --prefix=/opt/'
  command << " -n -v #{Workstation::VERSION} #{package_name}"
  shell_out!(command)
end
