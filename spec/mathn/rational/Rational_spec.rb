require 'mathn'

ruby_version_is '1.9' do
  describe "Kernel#Rational" do
    it "returns an Integer if denominator divides numerator evenly" do
      Rational(42,6).should == 7
      Rational(42,6).should be_kind_of(Fixnum)
      Rational(bignum_value,1).should == bignum_value
      Rational(bignum_value,1).should be_kind_of(Bignum)
    end
  end
end
