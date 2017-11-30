require 'date'

describe "Date#marshal_dump" do
  with_timezone("PST", +1) do
    before do
      @date = Date.new(2011, 7, 9)
      @dumped = @date.marshal_dump
    end

    it "dumps self" do
      @dumped.should == [0, (4911503/2r), 0, 0, 0, 2299161]
    end

    it "dumps @ajd within some bounds" do
      @dumped[1].should be_close(@date.ajd, 1)
    end
  end
end
