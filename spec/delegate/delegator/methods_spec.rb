require File.expand_path('../../fixtures/classes', __FILE__)

describe "Delegator#methods" do
  before :all do
    @simple = DelegateSpecs::Simple.new
    class << @simple
      def singleton_method
      end
    end

    @delegate = DelegateSpecs::Delegator.new(@simple)
    @methods = @delegate.methods
  end

  ruby_version_is ""..."1.9" do
    # See ruby_bug guarded spec below
    it "returns singleton methods when passed false" do
      @delegate.methods(false).should include("singleton_method")
    end

    it "includes all public methods of the delegate object" do
      @methods.should include "pub"
    end

    it "includes all protected methods of the delegate object" do
      @methods.should include "prot"
    end

    it "includes instance methods of the Delegator class" do
      @methods.should include "extra"
      @methods.should include "extra_protected"
    end

    it "does not include private methods" do
      @methods.should_not include "priv"
      @methods.should_not include "extra_private"
    end
  end

  ruby_version_is "1.9" do
    ruby_bug "4882", "1.9.3" do
      it "returns singleton methods when passed false" do
        @delegate.methods(false).should include(:singleton_method)
      end
    end

    it "includes all public methods of the delegate object" do
      @methods.should include :pub
    end

    it "includes all protected methods of the delegate object" do
      @methods.should include :prot
    end

    it "includes instance methods of the Delegator class" do
      @methods.should include :extra
      @methods.should include :extra_protected
    end

    it "does not include private methods" do
      @methods.should_not include :priv
      @methods.should_not include :extra_private
    end
  end
end
