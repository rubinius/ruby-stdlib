require 'io/wait'

describe 'IO#wait' do
  it 'returns nil when an IO has reached EOF' do
    read, write = IO.pipe

    write.close

    read.wait.should == nil
  end

  it 'raises IOError when an IO has been closed' do
    read, _ = IO.pipe

    read.close

    lambda { read.wait }.should raise_error(IOError)
  end
end
