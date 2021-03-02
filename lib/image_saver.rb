require 'httparty'
require 'uri'

class ImageSaver
  attr_reader :text_file, :image_folder

  def initialize(text_file, image_folder = 'images')
    @text_file = text_file
    @image_folder = image_folder
  end

  def call
    text = File.open(text_file).read
    text.gsub!(/\r\n?/, "\n")
    idx = 0
    text.each_line do |row|
      idx += 1
      row.scan(URI.regexp)
      response = HTTParty.get(row)

      if response.code == 200
        File.open(image_folder.concat("/image_#{idx}.png"), 'wb') do |file|
          file.write response
          puts code: response.code, message: 'Ok!'
        end
      else
        puts code: response.code, message: "Something went wrong: #{response.response}"
      end
    end
  end
end

ImageSaver.new('files/1.txt').call
