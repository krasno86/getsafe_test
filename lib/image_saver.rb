require 'uri'
require 'down'
require 'resque'
MAX_SIZE = 5 * 1024 * 1024
READ_TIMEOUT = 5
MAX_REDIRECTS = 0

class ImageSaver
  attr_reader :text_file, :image_folder

  def initialize(text_file, image_folder = 'images/')
    @text_file = text_file
    @image_folder = image_folder
  end

  def call
    Dir.mkdir('./images') unless File.exist?('./images')
    File.readlines(text_file).each do |row|
      row.chomp!
      if row.slice(URI::DEFAULT_PARSER.make_regexp(%w[http https])) == row
        begin
          remote_file = Down.open(row)
        rescue StandardError => e
          puts "Rescued: #{e.inspect}"
          next
        end

        tempfile = Down.download(row, max_size: MAX_SIZE, read_timeout: READ_TIMEOUT, max_redirects: MAX_REDIRECTS)

        if tempfile && remote_file.data[:status] == 200
          File.open(image_folder.concat(row.split('/').last), 'a') do |file|
            file.write tempfile
            puts code: remote_file.data[:status], message: 'Ok!'
          end
        else
          p 'Wrong format or bad connection'
        end
      else
        p 'Wrong url format!'
      end
    end
  end
end

ImageSaver.new('files/1.txt').call
