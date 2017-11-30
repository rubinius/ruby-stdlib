require File.expand_path('../shared/conjugate', __FILE__)

ruby_version_is "1.9" do
  describe "Matrix#conj" do
    it_behaves_like(:matrix_conjugate, :conj)
  end
end
