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
  FileUtils.rm_rf(package_name)
  berksfile = Berkshelf::Berksfile.from_file('Berksfile')
  berksfile.vendor(package_name)
end

desc 'Create debian package of the cookbooks'
task package: :vendor do
  package = "#{package_name}_#{Workstation::VERSION}_amd64.deb"
  File.unlink(package) if File.exist?(package)
  FileUtils.rm_rf(package_name) if Dir.exist?(package_name)
  command = 'bundle exec fpm -s dir -t deb --prefix=/opt'
  command << " --before-install scripts/before_install.sh"
  command << " --after-install scripts/after_install.sh"
  command << " -v #{Workstation::VERSION} -n #{package_name} #{package_name} etc"
  shell_out!(command)
end
