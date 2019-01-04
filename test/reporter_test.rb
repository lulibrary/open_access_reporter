require 'test_helper'

class TestReporter < Minitest::Test

  def reporter
    OpenAccessReporter::Reporter.new oa_config[:unpaywall_email]
  end

  def classifications
    %w{gold green bronze closed}
  end

  def test_initialize
    assert_instance_of OpenAccessReporter::Reporter, reporter
  end

  def doi_formats
    %w{
      10.1111/j.1461-0248.2008.01164.x,
      doi:10.1111/j.1461-0248.2008.01164.x,
      https://doi.org/doi:10.1111/j.1461-0248.2008.01164.x,
      https://dx.doi.org/10.1111/j.1461-0248.2008.01164.x
    }
  end

  def test_doi_formats_classification
    doi_formats.each do |doi|
      report = reporter.report doi
      refute_empty report
    end
  end

  def test_classification
    classification = reporter.classification doi_formats.first
    assert classifications.include? classification if classification
  end

end