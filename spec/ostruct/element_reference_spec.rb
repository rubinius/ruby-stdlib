require "ostruct"

describe "OpenStruct#[]" do
  before :each do
    @os = OpenStruct.new(:foo => 42)
  end

  it "returns the associated value using a symbol" do
    @os[:foo].should == 42
  end

  it "returns the associated value using a string" do
    @os["foo"].should == 42
  end
end
