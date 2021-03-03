require 'rubygems'
require 'test/unit'
require 'vcr_test'

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

class VCRTest < Test::Unit::TestCase
  def test_example_dot_com
    VCR.use_cassette("synopsis") do
      response = Net::HTTP.get_response(URI('https://images.freeimages.com/images/large-previews/c5a/chapada-1-1361193.jpg'))
      assert_match /Example domains/, response.body
    end
  end
end