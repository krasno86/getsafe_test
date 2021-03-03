require 'spec_helper'
require_relative '../lib/image_saver'

RSpec.describe ImageSaver do
  describe '.call' do
    let(:dir) { 'spec/fixtures/test_images/' }
    describe 'success' do
      before { FileUtils.rm_rf(Dir["#{dir}/*"]) }
      it 'save images' do
        Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
        ImageSaver.new('spec/fixtures/files/1.txt', dir).call
        expect(Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }) == 2
      end
    end

    describe 'failure' do
      before { FileUtils.rm_rf(Dir["#{dir}/*"]) }
      it 'fail saving images' do
        Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }
        ImageSaver.new('spec/fixtures/files/broken_link.txt', dir).call
        expect(Dir[File.join(dir, '**', '*')].count { |file| File.file?(file) }).to eq(0)
      end
    end
  end
end
