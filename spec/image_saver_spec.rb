# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/image_saver'

RSpec.describe ImageSaver do
  describe 'success image saving' do
    it 'images count in image folder is equal to images' do
      dir = 'spec/fixtures/test_images/'
      FileUtils.rm_rf(Dir["#{dir}/*"])
      Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
      ImageSaver.new('spec/fixtures/files/1.txt', dir).call
      expect(Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }) == 3
    end
  end

  describe 'error' do
    it 'sums the prices of the items in its line items' do
      dir = 'spec/fixtures/test_images/'
      FileUtils.rm_rf(Dir["#{dir}/*"])
      ImageSaver.new('spec/fixtures/files/broken_link.txt', dir).call
      expect(Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }).to eq(0)
    end
  end
end
