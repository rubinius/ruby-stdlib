require File.expand_path('../shared/valid_jd', __FILE__)
require 'date'

ruby_version_is "" ... "1.9" do
  describe "Date.exist1?" do
    it_behaves_like :date_valid_jd?, :exist1?
  end
end
