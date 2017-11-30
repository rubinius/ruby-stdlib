require 'socket'

describe 'BasicSocket.do_not_reverse_lookup' do
  before do
    @initial = BasicSocket.do_not_reverse_lookup
  end

  after do
    BasicSocket.do_not_reverse_lookup = @initial
  end

  it 'returns true by default' do
    BasicSocket.do_not_reverse_lookup.should == true
  end

  it 'returns false when set to false' do
    BasicSocket.do_not_reverse_lookup = false

    BasicSocket.do_not_reverse_lookup.should == false
  end
end

describe 'BasicSocket#do_not_reverse_lookup' do
  before do
    @sock = Socket.new(:INET, :STREAM, 0)
  end

  it 'returns true by default' do
    @sock.do_not_reverse_lookup.should == true
  end

  it 'returns false when set to false' do
    @sock.do_not_reverse_lookup = false

    @sock.do_not_reverse_lookup.should == false
  end
end
