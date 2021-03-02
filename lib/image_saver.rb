require 'csv'
require 'httparty'

class ImageSaver
  def initialize(text_file)
    @text_file= text_file
  end

  def call
    csv_text = File.read(@text_file)
    csv = CSV.parse(csv_text, headers: false)
    idx = 0
    csv.each do |row|
      idx += 1
      response = HTTParty.get(row.first)

      if response.code == 200
        File.open("images/image_#{idx}.png", 'wb') do |file|
          file.write response
          response.code
        end
      else
        puts code: response.code, message: "Something went wrong: #{response.response}"
      end
    end
  end
end

# ImageSaver.new('files/1.txt').call
