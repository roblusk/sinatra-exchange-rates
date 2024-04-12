require "sinatra"
require "sinatra/reloader"
require "http"

get("/") do
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  raw_response = HTTP.get(api_url)
  parsed_response = JSON.parse(raw_response)
  @currencies = parsed_response.fetch("currencies")
  erb(:home)
end

get("/:from_currency") do
  
end

get("/:from_currency/:to_currency") do
end
