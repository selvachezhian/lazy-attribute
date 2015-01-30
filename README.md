# Lazy Attribute

This gem provides a simple and extremely flexible way to use most frequent find_by query in a model.
You can minimize find_by query of a particular attribute in a model using lazy attribute gem.

## Installation

Add this line to your application's Gemfile:

    gem 'lazy-attribute', '~> 3.0.1'

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

```ruby
lazy_attribute :email, raise_error: true
```

Will give you the user object matches with the email and will raise ``` ActiveRecord::RecordNotFound ``` Exception if record not found

You can use more than one lazy_attribute to your model by providing unique key for that

```ruby
lazy_attribute :first_name, raise_error: true, key: :fn
```

```ruby
User.fn('first name')
```

## Contributing

1. Fork it ( https://github.com/selvachezhian/lazy-attribute/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
