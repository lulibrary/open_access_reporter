# Open Access Reporter

Uses the Unpaywall API (version 2) to gather Open Access information about research outputs with a DOI. Derives
a classification (e.g. Gold) wherever possible.

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
email = 'you@example.com'
reporter = OpenAccessReporter::Reporter.new email    
doi = '10.1098/rstb.2007.0013'
reporter.report doi
#=> {:best_oa_location=>..., :classification=>"bronze"}
````

The result is a hash of symbolised keys composed from the Unpaywall API JSON response verbatim and a derived 
classification. 

### Open access classification
The Unpaywall API leaves it up to the consumer to determine the Open Access type (e.g. Gold) based on the data it 
provides.

This gem uses the following rules:

is_oa | best_oa_location.host_type  | best_oa_location.license | TYPE
:---: | :---: | :---: | :---:
false | | | closed
true | repository | | green
true | publisher | null | bronze
true | publisher | not null | gold


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
