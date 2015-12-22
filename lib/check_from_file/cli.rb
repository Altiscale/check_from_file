require 'check_from_file'
require 'optparse'
require 'ostruct'

module CheckFromFile
  class CLI
    def self.parse(args)
      options = OpenStruct.new

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{$0} -c <command> -o <stdout> -e <stderr> -r <ret>"

        opts.on('-c', '--command COMMAND', :REQUIRED, 'Command that was run to generate this output') do |command|
          options[:command] = command
        end

        opts.on('-o', '--stdout FILE', 'File that contains STDOUT') do |stdout|
          options[:stdout] = stdout
        end

        opts.on('-e', '--stderr FILE', 'File that contains STDERR') do |stderr|
          options[:stderr] = stderr
        end

        opts.on('-r', '--return FILE', 'File that contains return code') do |ret|
          options[:return] = ret
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        opts.on_tail("--version", "Show version") do
          puts CheckFromFile::VERSION
          exit
        end
      end

      opt_parser.parse!(args)

      %w(command stdout stderr return).each do |opt|
        if options[opt.to_sym].nil?
          puts "Missing required option #{opt}"
          puts opt_parser
          exit 1
        end
      end
      options
    end
  end
end
