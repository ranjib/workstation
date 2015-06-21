require 'mixlib/shellout'

module Workstation
  module ShellOut
    def shell_out(command)
      cmd = Mixlib::ShellOut.new(command)
      cmd.live_stream = $stdout
      cmd.run_command
      cmd
    end

    def shell_out!(command)
      cmd = shell_out(command)
      fail "Failed to execute : '#{command}'" unless cmd.exitstatus.zero?
    end
  end
end
