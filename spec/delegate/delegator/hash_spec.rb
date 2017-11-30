require File.expand_path('../../fixtures/classes', __FILE__)

describe "Delegator#hash" do
  ruby_bug "redmine:2224", "1.8" do
    it "is delegated" do
      base = mock('base')
      delegator = DelegateSpecs::Delegator.new(base)
      base.should_receive(:hash).and_return(42)
      delegator.hash.should == 42
    end
  end
end
