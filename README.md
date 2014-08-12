# Omniauth Edmodo

This is the OmniAuth strategy for authenticating to Edmodo. TO use it, you'll need to obtain an OAuth2 application key and secret from Edmodo.

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-edmodo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-edmodo

## Basic Usage

    use OmniAuth::Builder do
      provider :edmodo, ENV['EDMODO_KEY'], ENV['EDMODO_SECRET'], scope: "basic,read_user_email"
    end

## Contributing

1. Fork it ( https://github.com/[my-github-username]/omniauth-edmodo/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
