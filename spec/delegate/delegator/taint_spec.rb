require File.expand_path('../../fixtures/classes', __FILE__)

describe "Delegator#taint" do
  before :each do
    @delegate = DelegateSpecs::Delegator.new("")
  end

  it "returns self" do
    @delegate.taint.equal?(@delegate).should be_true
  end

  it "taints the delegator" do
    @delegate.__setobj__(nil)
    @delegate.taint
    @delegate.tainted?.should be_true
  end

  ruby_bug "redmine:2223", "1.8" do
    it "taints the delegated object" do
      @delegate.taint
      @delegate.__getobj__.tainted?.should be_true
    end
  end
end
