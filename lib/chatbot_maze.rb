require 'http'
require 'json'
require 'dotenv'

Dotenv.load('.env')

api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/engines/text-davinci-003/completions"

headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

data = {
  "prompt" => conversation_history,
  "max_tokens" => 150,
  "n" => 1,
  "temperature" => 0.0
}

response = HTTP.post(url, headers: headers, body: data.to_json)
response_body = JSON.parse(response.body.to_s)
response_string = response_body['choices'][0]['text'].strip

puts "Voici 5 parfums de glace :"
puts response_string