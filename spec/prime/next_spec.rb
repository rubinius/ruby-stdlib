require File.expand_path('../shared/next', __FILE__)
require 'prime'

describe "Prime#next" do
  it_behaves_like :prime_next, :next
end


