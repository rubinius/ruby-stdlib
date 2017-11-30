require File.expand_path('../shared/identity', __FILE__)

describe "Matrix.I" do
  it_behaves_like(:matrix_identity, :I)
end
