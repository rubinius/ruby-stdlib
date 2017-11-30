require 'pathname'

describe "Kernel.Pathname" do
  it "returns a new Pathname Object with 1 argument" do
    Kernel.Pathname('').should be_kind_of(Pathname)
  end

  it "raises an ArgumentError when called with \0" do
    lambda { Kernel.Pathname("\0")}.should raise_error(ArgumentError)
  end

  it "is tainted if path is tainted" do
    path = '/usr/local/bin'.taint
    Kernel.Pathname(path).tainted?.should == true
  end
end
