require File.expand_path('../shared/include', __FILE__)
require 'set'

describe "Set#member?" do
  it_behaves_like :set_include, :member?
end
