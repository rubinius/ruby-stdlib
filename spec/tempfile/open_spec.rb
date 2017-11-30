require File.expand_path('../fixtures/common', __FILE__)
require 'tempfile'

describe "Tempfile#open" do
  before :each do
    @tempfile = Tempfile.new("specs")
    @tempfile.puts("Test!")
  end

  after :each do
    TempfileSpecs.cleanup @tempfile
  end

  it "reopens self" do
    @tempfile.close
    @tempfile.open
    @tempfile.closed?.should be_false
  end

  it "reopens self in read and write mode and does not truncate" do
    @tempfile.open
    @tempfile.puts("Another Test!")

    @tempfile.open
    @tempfile.readline.should == "Another Test!\n"
  end
end

describe "Tempfile.open" do
  after :each do
    TempfileSpecs.cleanup @tempfile
  end

  it "returns a new, open Tempfile instance" do
    @tempfile = Tempfile.open("specs")
    # Delegation messes up .should be_an_instance_of(Tempfile)
    @tempfile.instance_of?(Tempfile).should be_true
  end

  ruby_version_is "1.8.7" do
    it "is passed an array [base, suffix] as first argument" do
      Tempfile.open(["specs", ".tt"]) { |tempfile| @tempfile = tempfile }
      @tempfile.path.should =~ /specs.*\.tt$/
    end
  end
end

describe "Tempfile.open when passed a block" do
  before :each do
    ScratchPad.clear
  end

  after :each do
    TempfileSpecs.cleanup @tempfile
  end

  it "yields a new, open Tempfile instance to the block" do
    Tempfile.open("specs") do |tempfile|
      @tempfile = tempfile
      ScratchPad.record :yielded

      # Delegation messes up .should be_an_instance_of(Tempfile)
      tempfile.instance_of?(Tempfile).should be_true
      tempfile.closed?.should be_false
    end

    ScratchPad.recorded.should == :yielded
  end
  
  ruby_version_is ""..."1.9" do
    it "returns nil" do
      value = Tempfile.open("specs") do |tempfile|
        true
      end
      value.should be_nil
    end
  end

  ruby_version_is "1.9" do
    it "returns the value of the block" do
      value = Tempfile.open("specs") do |tempfile|
        "return"
      end
      value.should == "return"
    end
  end
  
  it "closes the yielded Tempfile after the block" do
    Tempfile.open("specs") { |tempfile| @tempfile = tempfile }
    @tempfile.closed?.should be_true
  end
end

