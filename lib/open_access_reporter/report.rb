module OpenAccessReporter
  class Report

    # @return [String, nil]
    attr_accessor :classification

    # @return [String, nil]
    attr_accessor :license

    # @return [String] ISO 8601 timestamp
    attr_accessor :modified_at

    attr_writer :open

    # @return [String]
    attr_accessor :title

    # @return [Boolean]
    def open?
      @open === true ? true : false
    end

  end
end