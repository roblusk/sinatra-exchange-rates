require "sinatra"
require "sinatra/reloader"
require "http"

def get_currencies()
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  raw_response = HTTP.get(api_url)
  parsed_response = JSON.parse(raw_response)
  return parsed_response.fetch("currencies")
end

get("/") do
  @currencies = get_currencies()
  erb(:home)
end

get("/:from_currency") do
  @currencies = get_currencies()
  @from_currency = params.fetch("from_currency")
  erb(:from_currency)
end

get("/:from_currency/:to_currency") do
end
