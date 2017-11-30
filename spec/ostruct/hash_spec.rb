require 'ostruct'

describe "OpenStruct#hash" do
  before :each do
    @os  = OpenStruct.new(:a => 1)
    @os2 = OpenStruct.new
  end

  it "returns a fixnum" do
    @os.hash.should be_an_instance_of(Fixnum)
  end

  it "returns the same fixnum for OpenStruct with the same content" do
    @os.hash.should_not == @os2.hash

    @os2.a = 1
    @os.hash.should == @os2.hash
  end
end
