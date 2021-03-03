require 'httparty'
require 'uri'

class ImageSaver
  attr_reader :text_file, :image_folder

  def initialize(text_file, image_folder = 'images/')
    @text_file = text_file
    @image_folder = image_folder
  end

  def self.valid_url?(url)
    url.slice(URI::regexp(%w(http https))) == url
  end

  def call
    text = File.read(text_file).split
    text.each do |row|
      if row.slice(URI::regexp(%w(http https))) == row
        response = HTTParty.get(row)

        if response.code == 200
          File.open(image_folder.concat(row.split('/').last), 'a') do |file|
            file.write response
            puts code: response.code, message: 'Ok!'
          end
        else
          puts code: response.code, message: "Something went wrong: #{response.response}"
        end
      else
        p 'invalid url'
      end
    end
  end
end

ImageSaver.new('files/1.txt').call
