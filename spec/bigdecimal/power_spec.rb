require File.expand_path('../shared/power', __FILE__)

describe "BigDecimal#power" do
  it_behaves_like(:bigdecimal_power, :power)
end
