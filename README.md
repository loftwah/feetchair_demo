# Feetchair Ruby on Rails Demo

To perform an end-to-end demo using Ruby and Ruby on Rails, you'll want to create a simple Rails application that communicates with an external API (in this case, `feetchair.fish.lgbt/api`). The demo will cover creating a new client, creating a flag, getting all flags, getting a single flag, updating a flag, and deleting a flag through the external API.

## Prerequisites

* Ruby and Ruby on Rails installed
* `httparty` gem for making HTTP requests
* `dotenv-rails` gem for managing environment variables

## Demo

1. **Create `.env` file** in the root of your Rails application:

```bash
   touch .env
```

2. Crate a client

```bash
rails runner lib/scripts/create_client.rb
```

3. Create a flag

```bash
rails runner lib/scripts/create_flag.rb
```

4. Get flags

```bash
rails runner lib/scripts/get_flags.rb
```

5. You need your ID for the next two so update the script with the ID of the flag you created and then run:

```bash
rails runner lib/scripts/get_flag.rb
rails runner lib/scripts/update_flag.rb
rails runner lib/scripts/delete_flag.rb
```

## Demonstrating Feature Flag Toggle

### Step 1: Update the Rails Application

Assuming you have the Rails application from Part One, we'll add a controller and views to demonstrate the feature flag toggle.

1. **Generate a Controller**

   ```bash
   rails generate controller Features
   ```

2. **Update Routes**

   Edit `config/routes.rb` to add a route for the feature demonstration:

   ```ruby
   Rails.application.routes.draw do
     get 'features/show'
     # Other routes
   end
   ```

### Step 2: Integrate Feature Flag Check

1. **Create a Service for Feature Flag**

   Create a service object that checks the status of the feature flag.

   ```bash
   mkdir app/services
   touch app/services/feature_flag_service.rb
   ```

   In `app/services/feature_flag_service.rb`:

   ```ruby
   require 'httparty'

   class FeatureFlagService
     def self.flag_active?(flag_id)
       response = HTTParty.get("https://feetchair.fish.lgbt/api/flags/#{flag_id}",
                               headers: {"Client-Id" => ENV['FEETCHAIR_CLIENT_ID'],
                                         "Client-Secret" => ENV['FEETCHAIR_CLIENT_SECRET']})
       if response.success?
         response.parsed_response['active']
       else
         false
       end
     end
   end
   ```

2. **Use Service in Controller**

   Update `app/controllers/features_controller.rb` to use this service to check the flag status:

   ```ruby
   class FeaturesController < ApplicationController
     def show
       @feature_active = FeatureFlagService.flag_active?('your-flag-id')
     end
   end
   ```

   Replace `'your-flag-id'` with the actual ID of your feature flag.

3. **Create Views**

   Create a view for the `show` action in `app/views/features/show.html.erb` to display different content based on the flag status:

   ```ruby
   <% if @feature_active %>
     <h1>Feature is ON</h1>
     <p>This is the new feature that is currently active.</p>
   <% else %>
     <h1>Feature is OFF</h1>
     <p>This feature is currently turned off.</p>
   <% end %>
   ```

#### Step 3: Demonstrate the Feature Toggle

1. **Start the Rails Server**

   ```bash
   rails server
   ```

2. **Visit the Feature Page**

   Go to `http://localhost:3000/features/show` in your browser to see the feature flag in action.

3. **Toggle the Feature Flag**

   Use the scripts from Part One to toggle the feature flag on and off, then refresh the page to see the changes in real-time.

### Final Notes for the Demo

* Prepare your environment variables in the `.env` file with valid `FEETCHAIR_CLIENT_ID` and `FEETCHAIR_CLIENT_SECRET` before starting the demo.
* Ensure the feature flag ID in the `FeatureFlagService` matches the one you're toggling during the demonstration.
* This setup allows you to visually show how feature flags can control access to new features in a live application, providing a clear, real-world example of feature flagging in action.
