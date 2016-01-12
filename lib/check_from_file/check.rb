require 'check_from_file'
require 'nagiosplugin'

module CheckFromFile
  class Check < Nagios::Plugin
    def initialize(options)
      @options = options
      @warning = false
      @critical = false
    end

    def critical?
      @critical = true unless @return == 0
      return @critical
    end

    def warning?
      return @warning
    end

    def ok?
      true
    end

    def check
      [:return, :stdout, :stderr].each do |file|
        @age = (Time.now - File.stat(@options[file]).mtime).to_i
        case
        when @age >= @options[:file_age_critical]
          @stale = @critical = true
          break
        when @age >= @options[:file_age_warning]
          @stale = @warning = true
          break
        end
      end

      @return = File.read(@options[:return]).to_i
      @stdout = File.read(@options[:stdout])
      @stderr = File.read(@options[:stderr])
    end

    def message
      return "One or more output files are #{@age} seconds old!" if @stale

      ret = "Command: #{@options[:command]} returned "
      if @critical
        ret << "#{@return}, STDOUT: #{@stdout}, STDERR: #{@stderr}"
      else
        ret << "successfully"
      end
      return ret
    end
  end
end
