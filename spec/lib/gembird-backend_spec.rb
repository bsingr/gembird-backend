require "spec_helper"

describe GembirdBackend do
  before :each do
    GembirdBackend.instance_variable_set('@retry', GembirdBackend::Retry.new(false))
    class CommandMock < GembirdBackend::Command
      attr_accessor :exec_count
      def exec command
        self.exec_count ||= 0
        self.exec_count += 1
        case command
        when /-g/
          command_result('socket-status.txt')
        else
          command_result('socket-status-error.txt')
        end
      end
    end
    @mock = CommandMock.new
    GembirdBackend.instance_variable_set("@command", @mock)
  end
  
  it 'should try 3 times' do
    GembirdBackend.on!.should be_nil
    @mock.exec_count.should == 3
  end
end
