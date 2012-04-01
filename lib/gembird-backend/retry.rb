module GembirdBackend
  class Retry
    attr_reader :delay
    def initialize(delay = true)
      @delay = delay
    end
    
    # try to make a successful call
    # retry n times in case of error
    # @param [Fixnum] n
    def try(n = 3, &block)
      try = lambda do
        begin
          block.call
        rescue ExecutionError => e
          GembirdBackend.logger.warn "retrying... #{e}"
          nil
        end
      end
      sleep_time = 0
      n.times do
        result = try.call
        return result if result
        sleep (2 ** sleep_time) if delay
        sleep_time += 1
      end
      nil
    end
  end
end
