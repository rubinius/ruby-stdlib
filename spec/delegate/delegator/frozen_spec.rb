require File.expand_path('../../fixtures/classes', __FILE__)

describe "Delegator when frozen" do
  before :all do
    @array = [42, :hello]
    @delegate = DelegateSpecs::Delegator.new(@array)
    @delegate.freeze
  end

  it "is still readable" do
    @delegate.should == [42, :hello]
    @delegate.include?("bar").should be_false
  end

  it "is frozen" do
    @delegate.frozen?.should be_true
  end

  ruby_bug "redmine:2221", "1.8.7" do
    it "is not writeable" do
      lambda{ @delegate[0] += 2 }.should raise_error( RuntimeError )
    end

    it "creates a frozen clone" do
      @delegate.clone.frozen?.should be_true
    end
  end

  it "creates an unfrozen dup" do
    @delegate.dup.frozen?.should be_false
  end

  ruby_version_is "" ... "1.9" do
    it "causes mutative calls to raise TypeError" do
      lambda{ @delegate.__setobj__("hola!") }.should raise_error( TypeError )
    end
  end

  ruby_version_is "1.9" do
    it "causes mutative calls to raise RuntimeError" do
      lambda{ @delegate.__setobj__("hola!") }.should raise_error( RuntimeError )
    end
  end

  it "returns false if only the delegated object is frozen" do
    DelegateSpecs::Delegator.new([1,2,3].freeze).frozen?.should be_false
  end
end
