require "pty"

describe "PTY.spawn" do
  before(:each) do
    @read, @write, @pid = PTY.spawn
  end

  it "allows reading from the first IO, and writing from the second IO" do
    @write.puts "sshao was here"
    @read.gets.should == "sshao was here\r\n"
  end
end
