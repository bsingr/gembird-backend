require "logger"
require File.join(File.dirname(__FILE__), "gembird-backend/scanner")
require File.join(File.dirname(__FILE__), "gembird-backend/parser")
require File.join(File.dirname(__FILE__), "gembird-backend/command")
require File.join(File.dirname(__FILE__), "gembird-backend/retry")
module GembirdBackend
  # when error occurs
  class ExecutionError < StandardError; end
  
  class << self
    def logger
      @logger ||= Logger.new(open('/dev/null', "w+"))
    end
    
    def parse result
      @parser ||= GembirdBackend::Parser.new
      @parser.parse result
    end
    
    def command
      @command ||= GembirdBackend::Command.new
    end
    
    def try &block
      @retry ||= GembirdBackend::Retry.new
      @retry.try &block
    end
    
    # @see GembirdBackend::Command#devices
    def devices
      try { parse command.devices }
    end
    
    # @see GembirdBackend::Command#on!
    def on! socket='all', options={}
      try { parse command.on! socket, options }
    end
    
    # @see GembirdBackend::Command#off!
    def off! socket='all', options={}
      try { parse command.off! socket, options }
    end
    
    # @see GembirdBackend::Command#toggle!
    def toggle! socket='all', options={}
      try { parse command.toggle! socket, options }
    end
    
    # @see GembirdBackend::Command#status
    def status socket='all', options={}
      try { parse command.status socket, options }
    end
  end
end
