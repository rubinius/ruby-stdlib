require File.expand_path('../../fixtures/classes', __FILE__)

describe "Delegator#untaint" do
  before :each do
    @delegate = lambda { DelegateSpecs::Delegator.new("") }.call
  end

  it "returns self" do
    @delegate.untaint.equal?(@delegate).should be_true
  end

  it "untaints the delegator" do
    @delegate.untaint
    @delegate.tainted?.should be_false
    # No additional meaningful test; that it does or not taint
    # "for real" the delegator has no consequence
  end

  ruby_bug "redmine:2223", "1.8" do
    it "untaints the delegated object" do
      @delegate.untaint
      @delegate.__getobj__.tainted?.should be_false
    end
  end
end
