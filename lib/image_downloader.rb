require 'uri'
require 'down'
require 'resque'

MAX_SIZE = 5 * 1024 * 1024
READ_TIMEOUT = 5
MAX_REDIRECTS = 0

module ImageDownloader
  def download_tempfile(row)
    row.chomp!
    if row.slice(URI::DEFAULT_PARSER.make_regexp(%w[http https])) == row
      tempfile_exist?(row)
    else
      p 'Wrong url format!'
      false
    end
  end

  def tempfile_exist?(row)
    begin
      tempfile = Down.download(row, max_size: MAX_SIZE, read_timeout: READ_TIMEOUT, max_redirects: MAX_REDIRECTS)
    rescue StandardError => e
      puts "Rescued: #{e.inspect}"
      return false
    end
    tempfile
  end
end
