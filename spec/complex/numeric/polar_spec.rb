require File.expand_path('../../../../shared/complex/numeric/polar', __FILE__)

ruby_version_is ""..."1.9" do

  require 'complex'
  require 'rational'

  describe "Numeric#polar" do
    it_behaves_like(:numeric_polar, :polar)
  end
end
