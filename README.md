# Lazy Attribute

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'lazy-attribute'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lazy-attribute

## Usage

In Model

```ruby
class User < ActiveRecord::Base

  lazy_attribute :email
  
end
```

```ruby
User['sample@email.com']
```

Will give you the user object matches with the email and will return nil if record not found

## Contributing

1. Fork it ( https://github.com/selvachezhian/lazy-attribute/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
