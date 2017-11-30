require File.expand_path('../shared/min', __FILE__)

describe "DateTime.minute" do
  ruby_version_is '1.9' do
    it_behaves_like :datetime_min, :minute
  end
end
