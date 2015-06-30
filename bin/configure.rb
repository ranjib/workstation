require_relative '../lib/workstation/cli'
module Workstation
  class Configure < Workstation::CLI
    banner 'configure --package PACKAGE.deb --host HOST_IP -u SSH_USER'

    option :host,
      long: '--host IP',
      short: '-h IP',
      description: 'IP address of the target host'

    option :ssh_user,
      long: '--user USER',
      short: '-u USER',
      description: 'SSH User name',
      default: ENV['USER']

    option :package,
      long: '--package COOKBOOKS_DEBIAN',
      short: '-p COOKBOOKS_DEBIAN',
      description: 'Path to debian package of the cookbooks',
      required: true

    def run
      prepare
      configure
    end

    def configure
      package_path = config[:package]
      package_file_name = File.basename(package_path)
      package_name = package_file_name.split('_').first
      blend('Configuring workstation') do |sched|
        sched.ssh_task "rm -f #{package_file_name}" do
          ignore_failure true
        end
        sched.scp_upload 'upload cookbooks package' do
          from package_path
          to package_file_name
        end
        sched.ssh_task "sudo apt-get remove -y --purge #{package_name}"
        sched.ssh_task "sudo dpkg -i #{package_file_name}"
        sched.ssh_task "rm -f #{package_file_name}"
      end
    end
  end
end

if $0 == __FILE__
  Workstation::Configure.new.run
end
