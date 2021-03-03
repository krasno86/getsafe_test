require_relative '../lib/url_validator'
require 'uri'
require 'down'
require 'resque'

MAX_SIZE = 5 * 1024 * 1024
READ_TIMEOUT = 5
MAX_REDIRECTS = 0

class ImageSaver
  extend UrlValidator
  attr_reader :text_file, :image_folder

  def initialize(text_file, image_folder = 'images/')
    @text_file = text_file
    @image_folder = image_folder
  end

  def call
    Dir.mkdir('./images') unless File.exist?('./images')
    File.readlines(text_file).each do |row|
      next unless ImageSaver.valid_url?(row)

      tempfile = Down.download(row, max_size: MAX_SIZE, read_timeout: READ_TIMEOUT, max_redirects: MAX_REDIRECTS)

      File.open(image_folder.concat(row.split('/').last), 'a') do |file|
        file.write tempfile
        puts code: :ok
      end
    end
  end
end
