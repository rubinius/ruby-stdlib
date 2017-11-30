require 'date'

describe "DateTime#strptime" do

  it "uses the default format" do
    DateTime.strptime("2000-04-06T01:01:01+01:00").should == DateTime.civil(2000, 4, 6, 1, 1, 1, '+1')
  end

  it "parses a second number since the Unix Epoch" do
    DateTime.strptime("-1", "%s").should == DateTime.civil(1969, 12, 31, 23, 59, 59)
    DateTime.strptime("-86400", "%s").should == DateTime.civil(1969, 12, 31, 0, 0, 0)
  end

  it "parses a millisecond number since the Unix Epoch" do
    DateTime.strptime("-999", "%Q").should == DateTime.civil(1969, 12, 31, 23, 59, 59 + 1.to_r/10**3)
    DateTime.strptime("-1000", "%Q").should == DateTime.civil(1969, 12, 31, 23, 59, 59)
  end

  it "parses seconds and timezone correctly" do
    DateTime.strptime("0 +0100", "%s %z").to_s.should == DateTime.civil(1970, 1, 1, 1, 0, 0, '+1').to_s
    DateTime.strptime("0 +0100", "%s %z").strftime("%s %z").should == "0 +0100"
  end

end
