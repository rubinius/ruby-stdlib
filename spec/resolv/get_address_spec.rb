require 'socket'

describe "Resolv#getaddress" do
  before(:all) do
    require 'resolv'
  end

  it "resolves localhost" do
    res = Resolv.new([Resolv::Hosts.new])

    lambda {
      address = res.getaddress("localhost")
    }.should_not raise_error(Resolv::ResolvError)
  end

  it "raises ResolvError if the name can not be looked up" do
    res = Resolv.new([])
    lambda {
      address = res.getaddress("should.raise.error.")
    }.should raise_error(Resolv::ResolvError)
  end

end
