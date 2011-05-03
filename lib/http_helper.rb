require 'net/http'

module HttpHelper
  def self.follow_redirects(url, options = {}, depth=0)
    return_type = options.fetch(:return, :url)

    uri = URI.parse(url)
    response = nil


    begin
      Net::HTTP.start(uri.host, uri.port) do |http|
        response = http.send((return_type==:url ? :head : :get), uri.path.blank? ? '/' : uri.path)
      end
    rescue EOFError, Net::HTTPBadResponse
      response = nil
    end

    if response && (response.code.to_s[0,1]=='3') && (depth<5) # redirect
      location = response['location']
      if location.starts_with? '/'
        location = "#{uri.scheme}://#{uri.host}:#{uri.port}#{location}"
      end

      return follow_redirects(location, options, depth+1)
    else
      return (return_type==:url) ? url : response
    end
  end

  def self.expand_url(url)
    follow_redirects(url, :return => :url)
  end
end
