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
  @from_currency = params.fetch("from_currency")
  @to_currency = params.fetch("to_currency")
  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@from_currency}&to=#{@to_currency}&amount=1"
  raw_response = HTTP.get(api_url)
  parsed_response = JSON.parse(raw_response)
  @result = parsed_response.fetch("result").to_s
  erb(:conversion)
end
