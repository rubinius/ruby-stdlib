require File.expand_path('../shared/collect', __FILE__)

describe "Matrix#map" do
  it_behaves_like(:collect, :map)
end
