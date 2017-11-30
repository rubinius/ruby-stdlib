require File.expand_path('../shared/identity', __FILE__)

describe "Matrix.identity" do
  it_behaves_like(:matrix_identity, :identity)
end
