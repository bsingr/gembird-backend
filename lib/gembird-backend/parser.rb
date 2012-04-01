module GembirdBackend
  class Parser
    # @param [String] result
    # @return [Array] stack of parsed result
    def parse result
      tokens = GembirdBackend::Scanner.new.scan result
      stack = []
      tokens.each do |token, *args|
        case token
          when :begin_device
            stack << {}
            stack.last[:number] = args.first.first
          when :device_type
            stack.last[:type] = args.first.first
          when :device_serial
            stack.last[:serial] = args.first.first
          when :usb_info
            stack.last[:usb_device] = args.first
            stack.last[:usb_bus] = args.last
          when :accessing_device
            stack << {}
            stack.last[:number] = args.first
            stack.last[:usb_device] = args.last
          when :socket_status
            stack.last[:sockets] ||= {}
            stack.last[:sockets][args.first] = args.last
          when :error
            raise GembirdBackend::ExecutionError, args.first
        end
      end
      stack
    end
  end
end
