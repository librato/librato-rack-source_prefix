# librato-rack-source_prefix

[![Gem Version](https://badge.fury.io/rb/librato-rack-source_prefix.svg)](https://badge.fury.io/rb/librato-rack-source_prefix) [![Build Status](https://travis-ci.org/librato/librato-rack-source_prefix.svg?branch=master)](https://travis-ci.org/librato/librato-rack-source_prefix)

This gem enables the automatic prefixing of metric source names. 

By default, when you submit a metric with a custom source, that source will be passed as-is to the Librato API. For example:

```ruby
Librato.increment :foo, source: "my.source"
```

The code above would result in the following data being POSTed to the Librato API:

```json
{
  "gauges": [ 
    {
      "name": "foo",
      "value": 1, 
      "source": "my.source"
    }
  ]
}
```

Note that the *source* passed to the API is identical to the value specified in the `increment` call. Even if you had configured a global *source* value (either via the `LIBRATO_SOURCE` environment variable or the *librato.yml* configuration file) the global *source* value is ignored completely.

If you were to configure a global source value of `myapp` and install the *librato-rack-source_prefix* gem, the same code shown above would result in the following data being POSTed:

```json
{
  "gauges": [ 
    {
      "name": "foo",
      "value": 1, 
      "source": "myapp.my.source"
    }
  ]
}
```

In this case, the *source* value specified as part of the `increment` call is automatically prefixed with the global source `myapp`.

To override this behavior and preserve the source name, use the `apply_prefix` option:
```ruby
Librato.increment :foo, source: "my.source", apply_prefix: false
```


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'librato-rack-source_prefix'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install librato-rack-source_prefix

If you are using the librato-rails gem, add this line to your librato.yml:

  | source_prefix: one.prefix.to.rule.them.all


### Rack Applications

If your application is using a non-Rails, Rack framework you'll need to add the following line to your app in order to enable the source prefixing behavior:

```ruby
  Librato::Collector.include(Librato::Rack::SourcePrefix::Extensions::Collector)
```

You'll want to add this line wherever you've configured your `Librato::Rack` middleware.

### Rails

If you are using Rails, source prefixing will be enabled automatically as a result of adding the *librato-rack-source_prefix* gem to your Gemfile. No additional configuration is required.

## Copyright

Copyright (c) 2015 [Librato Inc.](http://librato.com) See LICENSE for details.
