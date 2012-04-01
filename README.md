# GembirdBackend

This is a wrapper to provide ruby API for `sispmctl` script.

More info at the [sispmctl project page](http://sispmctl.sourceforge.net/).

[![Travis-CI Build Status](https://secure.travis-ci.org/dpree/gembird-backend.png)](https://secure.travis-ci.org/dpree/gembird-backend)

## Installation

Add this line to your application's Gemfile:

    gem gembird-backend

And then execute:

    bundle

Or install it yourself as:

    gem install gembird-backend

## Usage

**List all connected devices**

    require 'gembird-backend'
    
    GembirdBackend.devices
    # => [{:number=>"0",
    #      :usb_device=>"001",
    #      :usb_bus=>"004",
    #      :type=>"4-socket SiS-PM",
    #      :serial=>"02:01:48:af:e0"}]
    
    require 'gembird-backend'

**Check the status of the sockets for every connected device**

    require 'gembird-backend'
    GembirdBackend.socket
    # => [{:number=>"0",
    #      :usb_device => "003",
    #      :sockets=>{"1"=>"on",
    #                 "2"=>"off",
    #                 "3"=>"on",
    #                 "4"=>"off"}}]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

see LICENSE file
