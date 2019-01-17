# Mail::Jdec

A mail patch for decoding some inproper mails.

## Dependencies

* ruby 2.3+
* mail 2.7
* charlock_holmes (using libicu)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mail-jdec'
```

Then execute:

    $ bundle

## Usage

Use mail as usual. You can enable/disable patched features as follows:

```ruby
# disable patch
Mail::Jdec.disable

# enable patch
Mail::Jdec.enable
```

## Contributing

Pull requests are welcome at https://github.com/kanety/mail-jdec.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
