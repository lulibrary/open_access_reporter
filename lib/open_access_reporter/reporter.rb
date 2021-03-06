require 'http'
require 'libdoi'
require_relative 'report'

module OpenAccessReporter
  class Reporter
    # @param email [String] Email for Unpaywall API
    def initialize(email)
      raise ArgumentError, 'Unpaywall email not set' unless email && !email.empty?
      @email = email
      @http_client = HTTP::Client.new
    end

    # Find open access data for a research output (makes one Unpaywall API call, see documentation for restrictions)
    # @param doi [String] DOI e.g. 10.1234/abc, doi:10.1234/abc, https://doi.org/10.1234/abc
    # @return [OpenAccessReporter::Report, nil]
    def find(doi)
      unpaywall_object = fetch(doi)
      return nil if unpaywall_object[:error] === true
      report = OpenAccessReporter::Report.new
      report.classification = classification unpaywall_object
      report.open = open? unpaywall_object
      report.license = license unpaywall_object
      report.modified_at = modified_at unpaywall_object
      report.title = title unpaywall_object
      report
    end

    private

    # @return [Hash<Symbol>] Verbatim Unpaywall API JSON response
    def fetch(doi)
      doi = DOI.parse doi
      encoded_doi = encode_doi doi
      unpaywall_entry encoded_doi
    end

    def open?(unpaywall_object)
      unpaywall_object[:is_oa]
    end

    def title(unpaywall_object)
      unpaywall_object[:title]
    end

    def modified_at(unpaywall_object)
      unpaywall_object[:updated]
    end

    def license(unpaywall_object)
      if unpaywall_object[:is_oa] === true
        if !unpaywall_object[:best_oa_location].empty?
          unpaywall_object[:best_oa_location][:license]
        end
      end
    end

    def classification(unpaywall_object)
      if unpaywall_object[:is_oa] === true
        if unpaywall_object[:best_oa_location][:host_type] === 'repository'
          'green'
        elsif unpaywall_object[:best_oa_location][:host_type] === 'publisher' && unpaywall_object[:best_oa_location][:license].nil?
          'bronze'
        elsif unpaywall_object[:best_oa_location][:host_type] === 'publisher' && unpaywall_object[:best_oa_location][:license]
          'gold'
        end
      end
    end

    def unpaywall_entry(encoded_doi)
      unpaywall_object = @http_client.get "https://api.unpaywall.org/v2/#{encoded_doi}?email=#{@email}"
      JSON.parse unpaywall_object, symbolize_names: true
    end

    def encode_doi(doi)
      doi.to_uri.to_s.gsub 'https://doi.org/', ''
    end
  end
end