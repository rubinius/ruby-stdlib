require File.expand_path('../shared/sec', __FILE__)

describe "DateTime.sec" do
  it_behaves_like :datetime_sec, :sec
end
