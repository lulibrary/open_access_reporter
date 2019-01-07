# Open Access Reporter

Uses the Unpaywall API (version 2) to find the salient Open Access data for a research output with a DOI. Derives
a classification (e.g. gold) when possible.

## Status

[![Gem Version](https://badge.fury.io/rb/open_access_reporter.svg)](https://badge.fury.io/rb/open_access_reporter)


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
```ruby
email = 'somebody@example.com'
reporter = OpenAccessReporter::Reporter.new email    
doi = '10.1098/rstb.2007.0013'

report = reporter.find doi
#=> #<OpenAccessReporter::Report:0x00c0ffee>
 
report.classification
#=> "gold"

report.license
#=> "cc-by"

```` 

### Open access classification
The Unpaywall API leaves it up to the consumer to determine the Open Access classification (e.g. gold) based on the data 
it provides.

This gem uses the following rules:

is_oa | best_oa_location.host_type  | best_oa_location.license | classification
:---: | :---: | :---: | :---:
false | | | closed
true | repository | | green
true | publisher | null | bronze
true | publisher | not null | gold


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).