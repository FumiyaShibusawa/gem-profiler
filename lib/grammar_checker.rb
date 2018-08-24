require 'net/http'

class GrammarChecker
  class << self
    def strip_method_names_from(file)
      File.read(file).scan(/(def)\s{1}(.+)/).map { |_, name| name }
    end

    # don't know why search result won't show google dictionary's snippet at the top
    def request_to_google_dictionary(query)
      url = URI.parse("https://www.google.com/search?q=define+#{query}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      res = http.request(Net::HTTP::Get.new(url))
    end
  end
end