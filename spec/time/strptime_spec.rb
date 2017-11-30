require 'time'

describe "Time#strptime" do

  it "parses number of seconds since Unix Epoch" do
    Time.strptime('0', '%s').should == Time.at(0)
  end

  it "parses number of seconds since Unix Epoch as UTC" do
    Time.strptime('0', '%s').utc?.should == false
  end

  it "parses number of seconds since Unix Epoch with timezone" do
    Time.strptime('0 +0100', '%s %z').to_s.should == Time.at(0).getlocal('+01:00').to_s
    Time.strptime('0 +0100', '%s %z').strftime('%s %z').should == "0 +0100"
  end

end
