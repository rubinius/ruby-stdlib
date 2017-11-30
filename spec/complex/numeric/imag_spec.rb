require File.expand_path('../../../../shared/complex/numeric/imag', __FILE__)

ruby_version_is ""..."1.9" do

  require 'complex'
  require 'rational'

  describe "Numeric#imag" do
    it_behaves_like :numeric_imag, :imag
  end
end
