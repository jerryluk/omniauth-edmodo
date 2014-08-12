# Omniauth Edmodo

This is the OmniAuth strategy for authenticating to Edmodo. To use it, you'll need to obtain an OAuth2 application key and secret from Edmodo.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-edmodo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-edmodo

## Basic Usage

There is no difference between the following code and using each strategy indivually as middleware. This is an example that you might put into a Rails initializer at config/initializers/omniauth.rb

    Rails.application.config.use OmniAuth::Builder do
      provider :edmodo, ENV['EDMODO_KEY'], ENV['EDMODO_SECRET'], scope: "basic,read_user_email"
    end

See more at https://github.com/intridea/omniauth

## Contributing

1. Fork it ( https://github.com/[my-github-username]/omniauth-edmodo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
