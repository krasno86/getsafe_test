# frozen_string_literal: true

require_relative '../lib/image_downloader'

class ImageSaver
  extend ImageDownloader
  attr_reader :text_file

  def initialize(text_file)
    @text_file = text_file
  end

  def call
    Dir.mkdir('./images') unless File.exist?('./images')
    File.readlines(text_file).each do |row|
      ImageSaver.download_image(row)
    end
  end
end
