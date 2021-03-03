module UrlValidator
  def valid_url?(row)
    row.chomp!
    if row.slice(URI::DEFAULT_PARSER.make_regexp(%w[http https])) == row
      begin
        Down.open(row)
      rescue  => e
        puts "Rescued: #{e.inspect}"
        return false
      end
      true
    else
      p 'Wrong url format!'
      false
    end
  end
end
