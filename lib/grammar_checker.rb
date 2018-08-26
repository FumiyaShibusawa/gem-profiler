require 'net/http'

class GrammarChecker
  class << self
    def strip_method_names_from(file)
      File.read(file).scan(/(def)\s{1}(.+)/).map { |_, name| name }
    end

    def request_to_google_dictionary(query)
      # needs to build an aws server when major release,
      # but it uses a random free proxy server in US for now.
      proxy_addr = '139.59.2.223'
      proxy_port = '8888'

      proxy = Net::HTTP::Proxy(proxy_addr, proxy_port)
      url = URI.parse("https://www.google.com.au/search?q=define+#{query}")
      http = proxy.new(url.host, 443)
      http.use_ssl = true
      res = http.request(Net::HTTP::Get.new(url))
      res.body.scrub.scan(/(noun|verb)/)
    end
  end
end