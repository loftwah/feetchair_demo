# lib/scripts/get_flag.rb
require 'httparty'
require 'dotenv/load'

flag_id = '4950caaa-0eb9-482a-baf2-af71e4bf42b4' # Replace with actual flag ID
response = HTTParty.get("/flags/#{flag_id}",
                        headers: {
                          "x-client-id" => ENV['FEETCHAIR_CLIENT_ID'],
                          "x-client-secret" => ENV['FEETCHAIR_CLIENT_SECRET']
                        })

if response.success?
  puts "Flag details: #{response.body}"
else
  puts "Error fetching flag: #{response.body}"
end
