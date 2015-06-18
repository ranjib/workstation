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
vendor_path = File.expand_path('../workstation-cookbooks', __FILE__)

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
  FileUtils.rm_rf(vendor_path)
  berksfile = Berkshelf::Berksfile.from_file('Berksfile')
  berksfile.vendor(vendor_path)
end

desc 'Create debian package of the cookbooks'
task package: :vendor do
  command = 'bundle exec fpm -s dir -t deb --prefix=/opt'
  command << " -v #{Workstation::VERSION} -n #{package_name} #{vendor_path}"
  shell_out!(command)
end
