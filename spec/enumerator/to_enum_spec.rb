ruby_version_is ""..."1.9" do
  require File.expand_path('../../../shared/enumerator/enum_for', __FILE__)
  require 'enumerator'

  describe "#to_enum" do
    it_behaves_like :enum_for, :enum_for
  end
end
