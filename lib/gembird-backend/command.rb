module GembirdBackend
  class Command
    BIN = 'sispmctl' # the sispmctl binary
    
    # set dry to true for testing purposes
    attr_reader :dry
    def initialize dry=false
      @dry = dry
    end
    
    def call action, argument = nil, options = {}
      args = []
      if device = options[:device]
        # serial or number
        args << (device.to_s.include?(":") ? "-D" : "-d")
        args << device
      end
      args << (argument ? [action, argument] : action)
      command = build args
      dry ? command : exec(command)
    end
    
    def build *options
      [BIN, options].flatten.join ' '
    end
    
    def exec command
      `#{command}`
    end
    
    # scans for devices
    # @return [Array<Hash>] devices
    # @example return
    #     [{:number=>"0",
    #       :usb_device=>"001",
    #       :usb_bus=>"004",
    #       :type=>"4-socket SiS-PM",
    #       :serial=>"02:01:48:af:e0"}]
    def devices
      call '-s'
    end
    
    # switch a socket on
    # @return [Array<Hash>] devices
    # @see #status example return values
    def on! socket='all', options={}
      call '-o', socket, options
    end
    
    # switch a socket off
    # @return [Array<Hash>] devices
    # @see #status example return values
    def off! socket='all', options={}
      call '-f', socket, options
    end
    
    # toggle a socket
    # @return [Array<Hash>] devices
    # @see #status example return values
    def toggle! socket='all', options={}
      call '-t', socket, options
    end
    
    # get the status of a socket
    # @return [Array<Hash>] devices
    # @example return
    #     [{:number=>"0",
    #       :usb_device => "003",
    #       :sockets=>{"1"=>"on",
    #                  "2"=>"off",
    #                  "3"=>"on",
    #                  "4"=>"off"}}]
    #       :sockets=>{"1"=>"on", "2"=>"off", "3"=>"on", "4"=>"off"}}]
    def status socket='all', options={}
      call '-g', socket, options
    end
  end
end
