require 'http'
require 'libdoi'

module OpenAccessReporter
  class Reporter
    # @param email [String] Email for Unpaywall API
    def initialize(email)
      raise ArgumentError, 'Unpaywall email not set' unless email && !email.empty?
      @email = email
      @http_client = HTTP::Client.new
    end

    # @param doi [String] DOI e.g. 10.1234/abc, doi:10.1234/abc, https://doi.org/10.1234/abc
    def report(doi)
      doi = DOI.parse doi
      encoded_doi = encode_doi doi
      u = unpaywall_entry encoded_doi
      classification = open_access_classification(u)
      u.merge!({classification: classification}) if classification
      u
    end

    private

    def open_access_classification(unpaywall_object)
      return nil if unpaywall_object[:error] === true
      if unpaywall_object[:is_oa] === true
        return open_access_colour unpaywall_object
      else
        return 'closed'
      end
    end

    def open_access_colour(unpaywall_object)
      if unpaywall_object[:best_oa_location][:host_type] === 'repository'
        'green'
      elsif unpaywall_object[:best_oa_location][:host_type] === 'publisher' && unpaywall_object[:best_oa_location][:license].nil?
        'bronze'
      elsif unpaywall_object[:best_oa_location][:host_type] === 'publisher' && unpaywall_object[:best_oa_location][:license]
        'gold'
      end
    end

    def unpaywall_entry(encoded_doi)
      u = @http_client.get "https://api.unpaywall.org/v2/#{encoded_doi}?email=#{@email}"
      JSON.parse u, symbolize_names: true
    end

    def encode_doi(doi)
      doi.to_uri.to_s.gsub 'https://doi.org/', ''
    end
  end
end