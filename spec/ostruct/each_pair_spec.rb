require 'ostruct'

describe "OpenStruct#each_pair" do
  before :each do
    @os = OpenStruct.new("a" => 1, :b => 2)
  end

  it "returns an enumerator if no block given" do
    enum = @os.each_pair
    enum.should be_an_instance_of(enumerator_class)
    enum.to_a.should == [[:a, 1], [:b, 2]]
  end

  it "yields the key and value of each pair to a block expecting |key, value|" do
    all_args = []
    @os.each_pair { |key, value| all_args << [key, value] }
    all_args.sort.should == [[:a, 1], [:b, 2]]
  end
end
