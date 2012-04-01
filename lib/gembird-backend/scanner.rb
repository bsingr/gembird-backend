module GembirdBackend
  class Scanner
    # @param [String] result
    # @return [Array] tokens
    def scan result
      tokens = []
      result.split("\n").each do |line|
        
        ### socket
        if matched = line.match(/^Accessing Gembird #(.+) USB device (.+)$/)
          device_number, usb_device = *matched.captures
          tokens << [:accessing_device, device_number, usb_device]
        elsif matched = line.match(/outlet.+?(\d+).+?(on|off)/)
          socket_number, status = *matched.captures
          tokens << [:socket_status, socket_number, status]
        
        ### device
        elsif matched = line.match(/^Gembird #(.+)$/)
          device_number = *matched.captures
          tokens << [:begin_device, device_number]
        elsif matched = line.match(/device type:\s+(.+)/)
          device_type = *matched.captures
          tokens << [:device_type, device_type]
        elsif matched = line.match(/serial number:\s+(.+)/)
          device_serial = *matched.captures
          tokens << [:device_serial, device_serial]
        elsif matched = line.match(/USB information:\s+bus (.+), device (.+)/)
          usb_bus, usb_device = *matched.captures
          tokens << [:usb_info, usb_device, usb_bus]
        
        ### error
        elsif line =~ /error/i || line =~ /Check USB connections/
          tokens << [:error, result]
        elsif line =~ /Invalid number or given device not found/ ||
              line =~ /No device with serial number/
          tokens << [:device_not_found]
        else
          # noop
        end
      end
      tokens
    end
  end
end
