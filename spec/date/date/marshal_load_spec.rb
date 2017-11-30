require 'date'

describe "Date#marshal_load" do
  with_timezone("PST", +1) do
    before do
      @date = Date.new(2011, 7, 9)
      @dumped = [0, (4911503/2r), 0, 0, 0, 2299161]
      @loaded = Date.new
      @loaded.marshal_load(@dumped)
    end

    it "returns the loaded date" do
      @date.should == @loaded
    end

    it "loads @ajd within some bounds" do
      @loaded.ajd.should be_close(@dumped[1], 1)
    end
  end
end
