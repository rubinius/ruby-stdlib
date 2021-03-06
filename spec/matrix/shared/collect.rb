require 'matrix'

describe :collect, :shared => true do
  before :all do
    @m = Matrix[ [1, 2], [1, 2] ]
  end

  it "returns an instance of Matrix" do
    @m.send(@method){|n| n * 2 }.should be_kind_of(Matrix)
  end

  it "returns a Matrix where each element is the result of the block" do
    @m.send(@method) { |n| n * 2 }.should == Matrix[ [2, 4], [2, 4] ]
  end

  ruby_bug "#1531", "1.8.7" do
    it "returns an enumerator if no block is given" do
      @m.send(@method).should be_an_instance_of(enumerator_class)
    end
  end

  ruby_bug "redmine #5307", "1.9.3" do
    describe "for a subclass of Matrix" do
      it "returns an instance of that subclass" do
        MatrixSub.ins.send(@method){1}.should be_an_instance_of(MatrixSub)
      end
    end
  end
end
