require File.expand_path('../shared/transpose', __FILE__)

describe "Matrix#transpose" do
  it_behaves_like(:matrix_transpose, :t)
end
