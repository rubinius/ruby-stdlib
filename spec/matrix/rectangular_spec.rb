require File.expand_path('../shared/rectangular', __FILE__)

ruby_version_is "1.9" do
  describe "Matrix#rectangular" do
    it_behaves_like(:matrix_rectangular, :rectangular)
  end
end
