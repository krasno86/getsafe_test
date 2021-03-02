require 'csv'
require 'httparty'

class ImageSaver
  attr_reader :text_file, :image_folder

  def initialize(text_file, image_folder = 'images')
    @text_file = text_file
    @image_folder = image_folder
  end

  def call
    csv_text = File.read(text_file)
    csv = CSV.parse(csv_text, headers: false)
    idx = 0
    csv.each do |row|
      idx += 1
      response = HTTParty.get(row.first)

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

# ImageSaver.new('files/1.txt').call
