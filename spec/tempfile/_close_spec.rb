require File.expand_path('../fixtures/common', __FILE__)
require 'tempfile'

describe "Tempfile#_close" do
  before :each do
    @tempfile = Tempfile.new("specs")
  end

  after :each do
    TempfileSpecs.cleanup @tempfile
  end

  it "is protected" do
    Tempfile.should have_protected_instance_method(:_close)
  end

  it "closes self" do
    @tempfile.send(:_close)
    @tempfile.closed?.should be_true
  end
end
