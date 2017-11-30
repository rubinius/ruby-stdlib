require File.expand_path('../../../../shared/complex/numeric/real', __FILE__)

ruby_version_is ""..."1.9" do

  require 'complex'
  require 'rational'

  describe "Numeric#real" do
    it_behaves_like(:numeric_real, :real)
  end
end
