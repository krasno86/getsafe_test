# frozen_string_literal: true

require 'uri'
require 'down'

class ImageSaver
  attr_reader :text_file, :image_folder

  def initialize(text_file, image_folder = 'images/')
    @text_file = text_file
    @image_folder = image_folder
  end

  def call
    text = File.read(text_file).split
    Dir.mkdir('./images') unless File.exist?('./images')
    text.each do |row|
      status = Down.open(row).data[:status]

      if row.slice(URI::DEFAULT_PARSER.make_regexp(%w[http https])) == row && status == 200
        tempfile = Down.download(row, max_size: 5 * 1024 * 1024)

        if tempfile.content_type == 'image/jpeg'
          File.open(image_folder.concat(row.split('/').last), 'a') do |file|
            file.write tempfile
            puts code: status, message: 'Ok!'
          end
        else
          p 'Wrong format!'
        end
      else
        p code: status, message: 'Or invalid url'
      end
    end
  end
end
