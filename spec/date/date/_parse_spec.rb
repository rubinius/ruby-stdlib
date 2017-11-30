require 'date'

describe "Date#_parse" do
  it "parses 10:00 UTC as hour, min, zone and offset" do
    Date._parse("10:00 UTC").should == {
      :hour => 10,
      :min => 0,
      :offset => 0,
      :zone => "UTC",
    }
  end
end
