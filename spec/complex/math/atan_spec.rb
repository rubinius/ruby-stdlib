require 'complex'
require File.expand_path('../shared/atan', __FILE__)

describe "Math#atan" do
  it_behaves_like :complex_math_atan, :_, IncludesMath.new

  it "is a private instance method" do
    IncludesMath.should have_private_instance_method(:atan)
  end
end

ruby_version_is ""..."1.9" do
  describe "Math#atan!" do
    it_behaves_like :complex_math_atan_bang, :_, IncludesMath.new

    it "is a private instance method" do
      IncludesMath.should have_private_instance_method(:atan!)
    end
  end
end

describe "Math.atan" do
  it_behaves_like :complex_math_atan, :_, Math
end

ruby_version_is ""..."1.9" do
  describe "Math.atan!" do
    it_behaves_like :complex_math_atan_bang, :_, Math
  end
end
