# Open Access Reporter

Finds salient Open Access data and derives a classification for a research output with a DOI.

## Status

[![Gem Version](https://badge.fury.io/rb/open_access_reporter.svg)](https://badge.fury.io/rb/open_access_reporter)
[![Maintainability](https://api.codeclimate.com/v1/badges/f05eda4aa8b19c3d232c/maintainability)](https://codeclimate.com/github/lulibrary/open_access_reporter/maintainability)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'open_access_reporter'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install open_access_reporter

## Usage

### Configuration
```ruby
reporter = OpenAccessReporter::Reporter.new 'YOUR_EMAIL'  
```

### Find
```ruby
report = reporter.find '10.1234/foo'
#=> #<OpenAccessReporter::Report:0x00c0ffee>

report.open?
#=> true

report.classification
#=> "gold"

report.license
#=> "cc-by"
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).