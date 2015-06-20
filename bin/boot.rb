require 'blender'
require 'mixlib/cli'
require 'highline/import'
require_relative '../lib/workstation/version'

module Workstation
  class CLI
    include Mixlib::CLI

    banner 'boot --package PACKAGE.deb --host HOST_IP -u SSH_USER'

    option :host,
      long: '--host IP',
      short: '-h IP',
      description: 'IP address of the target host'

    option :package,
      long: '--package COOKBOOKS_DEBIAN',
      short: '-p COOKBOOKS_DEBIAN',
      description: 'Path to debian package of the cookbooks',
      required: true

    option :ssh_user,
      long: '--user USER',
      short: '-u USER',
      description: 'SSH User name',
      default: ENV['USER']

    def run
      parse_options
      password = ask('SSH Password: ') { |q| q.echo = false }
      ssh_config = {
        user: config[:user],
        password: password,
        stdout: $stdout
      }
      bootstrap(config[:host], ssh_config, config[:package])
    end

    def bootstrap(host, ssh_config, package)
      package_name = File.basename(package)
      Blender.blend('Bootstrapping workstation') do |sched|
        sched.members(host)
        sched.config(:ssh, ssh_config)

        sched.ssh_task 'sudo apt-get update -y'

        sched.ssh_task 'install wget' do
          execute 'sudo apt-get install wget'
        end

        sched.ssh_task 'download chef installer' do
          execute 'wget -c https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/10.04/x86_64/chef_12.3.0-1_amd64.deb'
        end

        sched.ssh_task 'install chef' do
          execute 'sudo dpkg -i chef_12.3.0-1_amd64.deb'
        end

        sched.scp_upload 'upload cookbooks package' do
          from package
          to package_name
        end

        sched.ssh_task 'install cookbooks package' do
          execute "sudo dpkg -i #{package_name}"
        end

        sched.ssh_task 'remove package' do
          execute "rm -rf #{package_name}"
        end
      end
    end
  end
end

if $0 == __FILE__
  Workstation::CLI.new.run
end
