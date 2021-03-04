# frozen_string_literal: true

require_relative '../lib/image_downloader'

class ImageSaver
  extend ImageDownloader
  attr_reader :text_file

  def initialize(text_file, _image_folder = 'images/')
    @text_file = text_file
  end

  def call
    Dir.mkdir('./images') unless File.exist?('./images')
    File.readlines(text_file).each do |row|
      image = ImageSaver.download_image(row)
      next unless image
    end
  end
end

ImageSaver.new(ARGV[0]).call
