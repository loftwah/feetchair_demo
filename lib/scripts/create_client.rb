require 'httparty'
require 'json'

response = HTTParty.post("https://feetchair.fish.lgbt/api/client", 
                          headers: { "Content-Type": "application/json" })

if response.code == 200
  json_response = JSON.parse(response.body)
  client_id = json_response["clientId"]
  client_secret = json_response["clientSecret"]

  # Print the values to confirm
  puts "FEETCHAIR_CLIENT_ID=#{client_id}"
  puts "FEETCHAIR_CLIENT_SECRET=#{client_secret}"

  # Write the values to the .env file
  File.open('.env', 'a') do |file|
    file.puts "FEETCHAIR_CLIENT_ID=#{client_id}"
    file.puts "FEETCHAIR_CLIENT_SECRET=#{client_secret}"
  end
  puts "Updated .env with actual FEETCHAIR_CLIENT_ID and FEETCHAIR_CLIENT_SECRET"
else
  puts "Error creating client: #{response.body}"
end
