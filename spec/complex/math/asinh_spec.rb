require 'complex'
require File.expand_path('../shared/asinh', __FILE__)

describe "Math#asinh" do
  it_behaves_like :complex_math_asinh, :_, IncludesMath.new

  it "is a private instance method" do
    IncludesMath.should have_private_instance_method(:asinh)
  end
end

ruby_version_is ""..."1.9" do
  describe "Math#asinh!" do
    it_behaves_like :complex_math_asinh_bang, :_, IncludesMath.new

    it "is a private instance method" do
      IncludesMath.should have_private_instance_method(:asinh!)
    end
  end
end

describe "Math.asinh" do
  it_behaves_like :complex_math_asinh, :_, Math
end

ruby_version_is ""..."1.9" do
  describe "Math.asinh!" do
    it_behaves_like :complex_math_asinh_bang, :_, Math
  end
end
