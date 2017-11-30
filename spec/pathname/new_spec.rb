require 'pathname'

describe "Pathname.new" do
  it "returns a new Pathname Object with 1 argument" do
    Pathname.new('').should be_kind_of(Pathname)
  end

  it "raises an ArgumentError when called with \0" do
    lambda { Pathname.new("\0")}.should raise_error(ArgumentError)
  end

  it "is tainted if path is tainted" do
    path = '/usr/local/bin'.taint
    Pathname.new(path).tainted?.should == true
  end

  it "calls #to_str to convert the argument to a String" do
    obj = mock("to_str")
    obj.should_receive(:to_str).and_return("/")

    Pathname.new(obj).should == Pathname.new('/')
  end

  it "calls #to_path to convert the argument to a String" do
    obj = mock("to_path")
    obj.should_receive(:to_path).and_return("/")

    Pathname.new(obj).should == Pathname.new('/')
  end
end

