require 'httparty'
require 'dotenv/load'

# Debugging output to ensure environment variables are loaded
puts "x-client-id: #{ENV['FEETCHAIR_CLIENT_ID']}"
puts "x-client-secret: #{ENV['FEETCHAIR_CLIENT_SECRET']}"

response = HTTParty.get("https://feetchair.fish.lgbt/api/flags",
                        headers: {
                          "x-client-id" => ENV['FEETCHAIR_CLIENT_ID'],
                          "x-client-secret" => ENV['FEETCHAIR_CLIENT_SECRET']
                        })

if response.success?
  puts "Flags: #{response.body}"
else
  puts "Error fetching flags: #{response.body}"
end
