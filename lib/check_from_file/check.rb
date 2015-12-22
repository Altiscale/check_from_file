require 'check_from_file'
require 'nagiosplugin'

module CheckFromFile
  class Check < Nagios::Plugin
    def initialize(options)
      @options = options
    end

    def critical?
      unless @return == 0
        @error = true
        return false
      end
    end

    def warning?
      false # We don't support a warning state, just critical or ok
    end

    def ok?
      true
    end

    def check
      @return = File.read(@options[:return]).to_i
      @stdout = File.read(@options[:stdout])
      @stderr = File.read(@options[:stderr])
    end

    def message
      ret = "Command: #{@options[:command]} returned "
      if @error
        ret << "#{@return}, STDOUT: #{@stdout}, STDERR: #{@stderr}"
      else
        ret << "successfully"
      end
      ret
    end
  end
end
