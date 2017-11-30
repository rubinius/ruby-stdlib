require File.expand_path('../../fixtures/classes', __FILE__)

describe "Delegator#private_methods" do
  before :all do
    @simple = DelegateSpecs::Simple.new
    @delegate = DelegateSpecs::Delegator.new(@simple)
    @methods = @delegate.private_methods
  end

  ruby_version_is ""..."1.9" do
    it "does not include any method of the delegate object" do # since delegates does not forward private calls
      @methods.should_not include "priv"
      @methods.should_not include "prot"
      @methods.should_not include "pub"
    end

    it "includes all private instance methods of the Delegate class" do
      @methods.should include "extra_private"
    end
  end

  ruby_version_is "1.9" do
    it "does not include any method of the delegate object" do # since delegates does not forward private calls
      @methods.should_not include :priv
      @methods.should_not include :prot
      @methods.should_not include :pub
    end

    it "includes all private instance methods of the Delegate class" do
      @methods.should include :extra_private
    end
  end
end
