require File.expand_path('../../../shared/complex/conjugate', __FILE__)

ruby_version_is ""..."1.9" do
  describe "Complex#conjugate" do
    it_behaves_like(:complex_conjugate, :conjugate)
  end
end
