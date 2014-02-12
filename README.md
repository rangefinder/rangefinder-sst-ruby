## Rangefinder Server-Side Tracking for Ruby

[Rangefinder](http://rangefinderapp.com/)'s server-side tracking allows you to record basic visitor information for every visitor, even those who block Rangefinder's client-side JavaScript. The client-side analytics fills in extra details, such as screen dimensions and page title, when/if it runs.

## Installation

This library is designed to run on Ruby 1.8 and newer. Please let me know if it doesn't.

```
gem install rangefinder-sst
```

## Usage

There are two ways to use the SST: as **standalone library** or as **Rack middleware**.

### Rack middleware

See [example/rack.ru](example/rack.ru) for an example of how to use the Rack middleware. More documentation coming soon.

### Library ###

The library code is in [lib/rangefinder/sst.rb](lib/rangefinder/sst.rb). It's short and should be very readable.

## License

Licensed under the New BSD License. See LICENSE for details.
