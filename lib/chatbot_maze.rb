require 'http'
require 'json'
require 'dotenv'

Dotenv.load('.env')

$api_key = ENV["OPENAI_API_KEY"]
$url = "https://api.openai.com/v1/engines/text-davinci-003/completions"

$headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{$api_key}"
}

def user_prompt(conversation_history)
  user_prompt = ""
  until user_prompt == "bye" do
    print "Vous> "
    user_prompt = gets.chomp
    conversation_history << "Vous> #{user_prompt}"
    converse_with_ai(user_prompt, conversation_history)
  end
puts conversation_history
end

def converse_with_ai(user_prompt, conversation_history)
  data = {
    "prompt" => user_prompt,
    "max_tokens" => 150,
    "n" => 1,
    "temperature" => 0.0
  }

  response = HTTP.post($url, headers: $headers, body: data.to_json)
  response_body = JSON.parse(response.body.to_s)
  response_string = response_body['choices'][0]['text'].strip
  conversation_history << "IA> #{response_string}"
  puts "IA> #{response_string}"
end

user_prompt([])
