require File.expand_path('../../fixtures/classes', __FILE__)

describe "Delegator#public_methods" do
  before :all do
    @simple = DelegateSpecs::Simple.new
    @delegate = DelegateSpecs::Delegator.new(@simple)
    @methods = @delegate.public_methods
  end

  ruby_version_is ""..."1.9" do
    it "includes public methods of the delegate object" do
      @methods.should include "pub"
    end

    it "includes public instance methods of the Delegator class" do
      @methods.should include "extra"
    end
  end

  ruby_version_is "1.9" do
    it "includes public methods of the delegate object" do
      @methods.should include :pub
    end

    it "includes public instance methods of the Delegator class" do
      @methods.should include :extra
    end
  end
end
