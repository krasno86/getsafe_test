# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/image_saver'

RSpec.describe ImageSaver do
  describe '.call', :vcr do
    let(:dir) { 'spec/fixtures/test_images/' }
    before { FileUtils.rm_rf(Dir["#{dir}/*"]) }
    describe 'success' do
      it 'save images' do
        ImageSaver.new('spec/fixtures/files/1.txt', dir).call
        expect(Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }) == 2
      end
    end

    describe 'failure' do
      it 'fail saving images' do
        ImageSaver.new('spec/fixtures/files/broken_link.txt', dir).call
        expect(Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }).to eq(0)
      end
    end
  end
end
