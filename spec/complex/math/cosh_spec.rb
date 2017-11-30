require 'complex'
require File.expand_path('../shared/cosh', __FILE__)

describe "Math#cosh" do
  it_behaves_like :complex_math_cosh, :_, IncludesMath.new

  it "is a private instance method" do
    IncludesMath.should have_private_instance_method(:cosh)
  end
end

ruby_version_is ""..."1.9" do
  describe "Math#cosh!" do
    it_behaves_like :complex_math_cosh_bang, :_, IncludesMath.new

    it "is a private instance method" do
      IncludesMath.should have_private_instance_method(:cosh!)
    end
  end
end

describe "Math.cosh" do
  it_behaves_like :complex_math_cosh, :_, Math
end

ruby_version_is ""..."1.9" do
  describe "Math.cosh!" do
    it_behaves_like :complex_math_cosh_bang, :_, Math
  end
end
