module OpenAccessReporter
  class Report

    # @return [String, nil]
    attr_accessor :classification

    # @return [Boolean] Is open access
    attr_accessor :is_oa

    # @return [String, nil]
    attr_accessor :license

    # @return [String] ISO 8601 timestamp
    attr_accessor :modified_at

    # @return [String]
    attr_accessor :title

    end
end