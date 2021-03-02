require 'spec_helper'
require 'lib/image_saver'

RSpec.describe ImageSaver do
  describe 'error' do
    it 'sums the prices of the items in its line items' do
      url = 'https://images.unsplash.com/photo-1591154669695-5f2a8d20c089?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NXx8dXJsfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60'
      expect(ImageSaver.new(url).call).to eq(200)
    end
  end

  describe 'error' do
    it 'sums the prices of the items in its line items' do

      expect(ImageSaver.new('empty_link').call).not_to eq(200)
    end
  end
end