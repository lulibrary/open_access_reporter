require 'test_helper'

class TestReporter < Minitest::Test

  def reporter
    OpenAccessReporter::Reporter.new config[:unpaywall_email]
  end

  def classifications
    %w{gold green bronze}
  end

  def test_initialize
    assert_instance_of OpenAccessReporter::Reporter, reporter
  end

  def doi_formats
    %w{
      10.1111/j.1461-0248.2008.01164.x
      doi:10.1111/j.1461-0248.2008.01164.x
      https://doi.org/doi:10.1111/j.1461-0248.2008.01164.x
      https://dx.doi.org/10.1111/j.1461-0248.2008.01164.x
    }
  end

  def test_entry_with_various_doi_formats
    doi_formats.each do |doi|
      report = reporter.find doi

      classification = report.classification
      assert_instance_of String, classification if classification
      assert classifications.include? classification if classification

      license = report.license
      assert_instance_of String, license if license

      assert [true, false].include?(report.open?)

      refute_empty report.modified_at
      assert_instance_of String, report.modified_at

      refute_empty report.title
      assert_instance_of String, report.title
    end
  end

  def test_no_entry
    doi = '10.1234/foo'
    report = reporter.find doi

    assert_instance_of NilClass, report
  end

end