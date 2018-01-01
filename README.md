# ValidateParams

Params validations for Ruby on Rails.

[![Build Status](https://circleci.com/gh/rdelandesen/validate_params.svg?&style=shield&circle-token=07c20c3f9486aeae32f2ce63ef5f956ba26b968f)](https://circleci.com/gh/rdelandesen/validate_params)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'validate_params'
```

And then execute:

```bash
$ bundle
```

## Usage

In your controller:

```ruby
class ExamplesController < ApplicationController
  include ValidateParams

  def create
    validate_params! :example
    # [...]
  end
end
```

You can rescue from exception like this:

```ruby
class ApplicationController < ActionController::Base
  rescue_from InvalidParamsException do |exception|
    respond_to do |format|
      format.json { render json: { error: exception.to_s }, status: 400 }
      format.html { raise ActionController::RoutingError.new('Not found') }
    end

  end
end
```

### Validate presence

```ruby
validate_params! :user
```

```ruby
validate_params! :user, :token
```

### Validate type and size

```ruby
validate_params! user: Array
```

```ruby
validate_params! user: { type: Array }
```

```ruby
validate_params! user: Array, token: String
```

```ruby
validate_params! example: { type: Array, size: 2 }
```

### Validate that value is included in a range

```ruby
validate_params! number: { range: 0..10 }
```

### Validate inclusion

```ruby
validate_params! example: { in: %w(value1 value2) }
```

### Validate regex

```ruby
validate_params! example: { regex: /myregex/ }
```

### Validation from custom Proc

```ruby
validate_params! example: { custom: Proc.new { |value| value == 'a' } }
```

### Set default value

```ruby
validate_params! example: { default: 'abc' }
```

### Cast

```ruby
# :Integer :Float or :Array
validate_params! example: { cast: :Integer }
```

## Todo

- Add a `validate_params` method (without `!`) that returns false
- Config custom exception class

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rdelandesen/validate_params.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
