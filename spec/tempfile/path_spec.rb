require File.expand_path('../fixtures/common', __FILE__)
require 'tempfile'

describe "Tempfile#path" do
  before :each do
    @tempfile = Tempfile.new("specs", tmp(""))
  end

  after :each do
    TempfileSpecs.cleanup @tempfile
  end

  it "returns the path to the tempfile" do
    tmpdir = tmp("")
    path = @tempfile.path

    platform_is :windows do
      # on Windows, both types of slashes are OK,
      # but the tmp helper always uses '/'
      path.gsub!('\\', '/')
    end

    path[0, tmpdir.length].should == tmpdir
    path.should include("specs")
  end
end
