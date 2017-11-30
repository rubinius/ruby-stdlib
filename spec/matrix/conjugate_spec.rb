require File.expand_path('../shared/conjugate', __FILE__)

ruby_version_is "1.9" do
  describe "Matrix#conjugate" do
    it_behaves_like(:matrix_conjugate, :conjugate)
  end
end
