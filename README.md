# CheckFromFile

This gem is intended to check the output of another command and return as if the
other command had been run.  This is useful if you run things via cron and want
to check their output.  One reason you might want to run a check like this is
so that you can avoid giving nrpe / sensu credentials to an authenticated service.

## Limitations

Currently it only checks the return code and reports and error on non-zero.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'check_from_file'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install check_from_file

## Usage

```
Usage: check_from_file -c COMMAND -o STDOUT -e STDERR -r RETURN
    -c, --command COMMAND            Command that was run to generate this output
    -o, --stdout FILE                File that contains STDOUT
    -e, --stderr FILE                File that contains STDERR
    -r, --return FILE                File that contains return code
    -h, --help                       Show this message
        --version                    Show version
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Altiscale/check_from_file. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

