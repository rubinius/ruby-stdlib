require File.expand_path('../shared/trace', __FILE__)
require 'matrix'

describe "Matrix#tr" do
  it_behaves_like(:trace, :tr)
end
