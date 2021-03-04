require_relative '../lib/image_downloader'

class ImageSaver
  extend ImageDownloader
  attr_reader :text_file, :image_folder

  def initialize(text_file, image_folder = 'images/')
    @text_file = text_file
    @image_folder = image_folder
  end

  def call
    Dir.mkdir('./images') unless File.exist?('./images')
    File.readlines(text_file).each do |row|
      tempfile = ImageSaver.download_tempfile(row)
      next unless tempfile
    end
  end
end
