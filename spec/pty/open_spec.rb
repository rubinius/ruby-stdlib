require "pty"

describe "PTY.open" do
  before(:each) do
    @master, @slave = PTY.open
  end

  after(:each) do
    @master.close
    @slave.close
  end

  it "returns master as an IO object" do
    @master.class.should == IO
  end

  it "returns slave as a File object" do
    @slave.class.should == File
  end

  it "returns master and slave as ttys" do
    @master.tty?.should == true
    @slave.tty?.should == true
  end

  it "returns slave as a device file" do
    @slave.stat.chardev?.should == true
  end

  it "syncs master and slave" do
    @master.sync.should == true
    @slave.sync.should == true
  end

  it "allows writing to master, and reading from slave" do
    @master.puts "sshao was here"
    @slave.gets.should == "sshao was here\n"
  end

  it "sets master and slave fd flags to 2" do
    require "fcntl"
    @master.fcntl(Fcntl::F_GETFL).should == 2
    @slave.fcntl(Fcntl::F_GETFL).should == 2
  end

  it "sets master and slave to close on exec" do
    @master.close_on_exec?.should == true
    @slave.close_on_exec?.should == true
  end
end
