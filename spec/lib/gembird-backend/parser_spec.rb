require "spec_helper"

describe GembirdBackend::Parser do
  before :each do
    @parser = GembirdBackend::Parser.new
  end
  
  it 'lists all devices' do
    @parser.parse(command_result('devices.txt')).should == \
      [{:number=>"0", :usb_device=>"001", :usb_bus=>"004",
       :type=>"4-socket SiS-PM", :serial=>"02:01:48:af:e0"}]
  end
  
  it 'lists all sockets' do
    @parser.parse(command_result('socket-status.txt')).should == \
      [{:number=>"0", :usb_device => "003",
        :sockets=>{"1"=>"on", "2"=>"off", "3"=>"on", "4"=>"off"}}]
  end
  
  it 'detects error' do
    lambda do
      @parser.parse(command_result('socket-status-error.txt'))
    end.should raise_error(GembirdBackend::ExecutionError)
  end
  
  it 'detects connection loss' do
    lambda do
      @parser.parse(command_result('no-connection.txt'))
    end.should raise_error(GembirdBackend::ExecutionError)
  end
end
