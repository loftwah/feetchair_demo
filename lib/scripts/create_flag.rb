require 'httparty'
require 'dotenv/load'

# Ensure the endpoint matches the API documentation for creating a flag
url = "https://feetchair.fish.lgbt/api/flags"

# Prepare the request body with the correct field and value
body = {
  name: "loftwah",
  description: "Loftwah says hi",
  enabled: true # Ensure this is a boolean value
}.to_json

# Execute the POST request with the corrected headers
response = HTTParty.post(url,
                         body: body,
                         headers: {
                           "Content-Type" => "application/json",
                           "x-client-id" => ENV['FEETCHAIR_CLIENT_ID'], # Use the correct header key
                           "x-client-secret" => ENV['FEETCHAIR_CLIENT_SECRET'] # Use the correct header key
                         })

# Check the response
if response.success?
  puts "Flag created successfully: #{response.body}"
else
  # Print error message from the API if the request was not successful
  puts "Error creating flag: #{response.body}"
end
