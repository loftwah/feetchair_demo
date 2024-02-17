# config/initializers/httparty.rb
HTTParty::Basement.default_options.update({
  headers: { 'Content-Type' => 'application/json' },
  base_uri: 'https://feetchair.fish.lgbt/api'
})
