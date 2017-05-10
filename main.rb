require 'net/http'
require 'sinatra'
require 'uri'

get %r{/([a-zA-Z0-9_]+)/items/([a-f0-9]+)} do |username, hash|
  qiita_host = 'http://qiita.com'
  request = "/#{username}/items/#{hash}"
  url = URI.parse(qiita_host)
  res = Net::HTTP.start(url.host, url.port) do |http|
    http.get(request)
  end
  redirect (res.code == '200' ?
              qiita_host + request
            : "http://web.archive.org/web/*/#{qiita_host}#{request}")
end
