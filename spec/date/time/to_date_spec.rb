require 'date'

describe "Time#to_date" do
  describe "date before the Gregorian calendar adoption in Italy" do
    it "converts a Gregorian Time object into a Julian Date object" do
      date = Time.local(1582, 10, 14).to_date
      date.julian?.should be_true
      date.gregorian?.should be_false

      date.year.should == 1582
      date.mon.should == 10
      date.mday.should == 4
    end
  end

  describe "date after the Gregorian calendar adoption in Italy" do
    it "converts a Gregorian Time object into a Gregorian Date object" do
      date = Time.local(1582, 10, 15).to_date
      date.julian?.should be_false
      date.gregorian?.should be_true

      date.year.should == 1582
      date.mon.should == 10
      date.mday.should == 15
    end
  end
end
