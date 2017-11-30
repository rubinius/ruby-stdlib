require "ostruct"

describe "OpenStruct#[]=" do
  before :each do
    @os = OpenStruct.new(:bar => 100)
  end

  it "sets the associated value using a symbol" do
    @os[:foo] = 42
    @os.foo.should == 42
  end

  it "sets the associated value using a string" do
    @os["foo"] = 42
    @os.foo.should == 42
  end

  it "updates the associated value using a symbol" do
    @os[:bar] = 42
    @os.bar.should == 42
  end

  it "updates the associated value using a string" do
    @os["bar"] = 42
    @os.bar.should == 42
  end
end
