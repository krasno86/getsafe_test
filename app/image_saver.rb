require 'csv'
require 'httparty'

csv_text = File.read('files/1.txt')
csv = CSV.parse(csv_text, headers: false)
idx = 0
csv.each do |row|
  idx += 1
  response = HTTParty.get(row.first)

  if response.code == 200
    File.open("images/image_#{idx}.png", 'wb') do |file|
      file.write response
    end
  else
    puts code: response.code, message: "Something went wrong: #{response.response}"
  end
end
