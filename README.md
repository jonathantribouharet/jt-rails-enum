# JTRailsEnum

[![Gem Version](https://badge.fury.io/rb/jt-rails-enum.svg)](http://badge.fury.io/rb/jt-rails-enum)

JTRailsEnum let you use enum in your models. JTRailsEnum doesn't works exactly like `enum` in Ruby On Rails. It always add a prefix, which is a better behavior when you use multiple enums in a model. The `prefix` option is also not present in the Ruby On Rails 4.0.

## Installation

JTRailsEnum is distributed as a gem, which is how it should be used in your app.

Include the gem in your Gemfile:

    gem 'jt-rails-enum', '~> 1.0'

## Usage

### Basic usage

```ruby
class User < ActiveRecord::Base

    jt_enum confirmation_status: [
        :waiting,
        :accepted,
        :refused
    ]

end
```

Scopes and some basic methods are automatically created for each value in the enum.
```ruby
# User.where(confirmation_status: User.confirmation_statuses[:waiting]).first
user = User.confirmation_status_waiting.first

# Equivalent to user.update!(confirmation_status: User.confirmation_statuses[:accepted])
user.confirmation_status_accepted!

# Equivalent to user.confirmation_status == User.confirmation_statuses[:accepted]
user.confirmation_status_accepted?

```

## Author

- [Jonathan Tribouharet](https://github.com/jonathantribouharet) ([@johntribouharet](https://twitter.com/johntribouharet))

## License

JTRailsEnum is released under the MIT license. See the LICENSE file for more info.
