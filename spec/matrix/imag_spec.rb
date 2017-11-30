require File.expand_path('../shared/imaginary', __FILE__)

ruby_version_is "1.9" do
  describe "Matrix#imag" do
    it_behaves_like(:matrix_imaginary, :imag)
  end
end
