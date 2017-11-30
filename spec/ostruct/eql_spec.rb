require 'ostruct'

describe "OpenStruct#eql?" do
  before :each do
    @os = OpenStruct.new(:a => 1, :b => 2)
  end

  it "returns true when the passed argument is an OpenStruct and contains the same hash table" do
    os2 = OpenStruct.new(:a => 1, :b => 2)
    @os.should eql(os2)
  end

  it "returns false when the passed argument is an OpenStruct and contains a different hash table" do
    os2 = OpenStruct.new(:a => 2, :b => 2)
    @os.should_not eql(os2)
  end

  it "returns false when the passed argument isn't an OpenStruct" do
    h = {:a => 1, :b => 2}
    @os.should_not eql(h)
  end
end
