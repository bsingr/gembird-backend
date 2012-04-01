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
    def devices
      call '-s'
    end
    
    # switch a socket on
    def on! socket='all', options={}
      call '-o', socket, options
    end
    
    # switch a socket off
    def off! socket='all', options={}
      call '-f', socket, options
    end
    
    # toggle a socket
    def toggle! socket='all', options={}
      call '-t', socket, options
    end
    
    # get the status of a socket
    def status socket='all', options={}
      call '-g', socket, options
    end
  end
end
