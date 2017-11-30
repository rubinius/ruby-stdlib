require 'mathn'

describe "Integer#prime_division" do
  it "Performs a prime factorization of a positive integer" do
    100.prime_division.should == [[2, 2], [5, 2]]
  end

  # Proper handling of negative integers has been added to MRI trunk
  # in revision 24091. Prior to that, all versions of MRI returned nonsense.
  ruby_bug "trunk@24091", "1.9.1" do
    it "Performs a prime factorization of a negative integer" do
      -26.prime_division.should == [[-1, 1], [2, 1], [13, 1]]
    end
  end

  it "raises a ZeroDivisionError when is called on zero" do
    lambda { 0.prime_division }.should raise_error(ZeroDivisionError)
  end
end
