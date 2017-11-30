require 'date'
require File.expand_path('../shared/ordinal', __FILE__)

describe "Date.ordinal" do
  it_behaves_like :date_ordinal, :ordinal
end

