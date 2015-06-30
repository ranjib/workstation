require_relative '../lib/workstation/cli'

module Workstation
  class Boot < Workstation::CLI
    banner 'boot --package PACKAGE.deb --host HOST_IP -u SSH_USER'

    option :host,
      long: '--host IP',
      short: '-h IP',
      description: 'IP address of the target host'

    option :ssh_user,
      long: '--user USER',
      short: '-u USER',
      description: 'SSH User name',
      default: ENV['USER']

    def run
      prepare
      bootstrap
    end

    def bootstrap
      blend('Installing chef') do |sched|
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

      end
    end
  end
end

if $0 == __FILE__
  Workstation::Boot.new.run
end
