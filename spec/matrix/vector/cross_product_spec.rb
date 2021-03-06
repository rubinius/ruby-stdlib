require 'matrix'

ruby_version_is "2.1.0" do
  describe "Vector#cross_product" do
    it "returns the cross product of a vector" do
      Vector[1, 0, 0].cross_product(Vector[0, 1, 0]).should == Vector[0, 0, 1]
      Vector[1, 2, 3].cross_product(Vector[0, -4, 5]).should == Vector[22, -5, -4]
    end

    it "accepts an array parameter" do
      Vector[1, 2, 3].cross_product([0, -4, 5]).should == Vector[22, -5, -4]
    end

    it "raises an error unless both vectors have dimension 3" do
      lambda {
        Vector[1, 2, 3].cross_product(Vector[0, -4])
      }.should raise_error(Vector::ErrDimensionMismatch)
      lambda {
        Vector[1, 2].cross_product(Vector[0, 1, 2])
      }.should raise_error(Vector::ErrDimensionMismatch)
      lambda {
        Vector[1, 2].cross_product(Vector[1, 2])
      }.should raise_error(Vector::ErrDimensionMismatch)
    end
  end
end
