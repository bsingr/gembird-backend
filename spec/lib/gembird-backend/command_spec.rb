require "spec_helper"

describe GembirdBackend::Command do
  before :each do
    @command = GembirdBackend::Command.new(true)
  end
  
  it 'builds empty command' do
    @command.build.should == 'sispmctl'
  end
  
  it 'builds any command' do
    @command.build('foo', 'bar').should == 'sispmctl foo bar'
  end
  
  describe '#devices' do
    it 'scans all' do
      @command.devices.should == 'sispmctl -s'
    end
  end
  
  describe '#status' do
    it 'retrieves all' do
      @command.status.should == 'sispmctl -g all'
    end
    it 'retrieves single' do
      @command.status(1).should == 'sispmctl -g 1'
    end
    it 'retrieves single for device' do
      @command.status(1, :device=>"aa:bb").should == 'sispmctl -D aa:bb -g 1'
    end
  end
  
  describe '#on!' do
    it 'switches all on' do
      @command.on!.should == 'sispmctl -o all'
    end
    it 'switches single on' do
      @command.on!(1).should == 'sispmctl -o 1'
    end
    it 'switches single for device' do
      @command.on!(1, :device=>"123").should == 'sispmctl -d 123 -o 1'
    end
  end
  
  describe '#off!' do
    it 'switches all off' do
      @command.off!.should == 'sispmctl -f all'
    end
    it 'switches single off' do
      @command.off!(1).should == 'sispmctl -f 1'
    end
    it 'switches single for device off' do
      @command.off!(1, :device=>1).should == 'sispmctl -d 1 -f 1'
    end
  end
  
  describe '#toggle!' do
    it 'toggles all' do
      @command.toggle!.should == 'sispmctl -t all'
    end
    it 'toggles single' do
      @command.toggle!(1).should == 'sispmctl -t 1'
    end
    it 'toggles single for device' do
      @command.toggle!(1, :device=>1).should == 'sispmctl -d 1 -t 1'
    end
  end
end
  