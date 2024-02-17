# lib/scripts/update_flag.rb
require 'httparty'
require 'dotenv/load'

flag_id = '4950caaa-0eb9-482a-baf2-af71e4bf42b4' # Replace with actual flag ID
body = {
  name: "loftwah2",
  description: "Loftwah says bye",
  enabled: true # Ensure this is a boolean value
}.to_json

response = HTTParty.put("/flags/#{flag_id}",
                        body: body,
                        headers: {
                          "Content-Type" => "application/json",
                          "x-client-id" => ENV['FEETCHAIR_CLIENT_ID'],
                          "x-client-secret" => ENV['FEETCHAIR_CLIENT_SECRET']
                        })

if response.success?
  puts "Flag updated successfully."
else
  puts "Error updating flag: #{response.body}"
end
