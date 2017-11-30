require 'date'

ruby_version_is "" ... "1.9" do
  describe "Date.neww" do
    it_behaves_like :date_commercial, :neww
  end
end
