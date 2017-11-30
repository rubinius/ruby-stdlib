require File.expand_path('../shared/eql.rb', __FILE__)

describe "BigDecimal#eql?" do
  it_behaves_like(:bigdecimal_eql, :eql?)
end
