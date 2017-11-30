require 'mathn'

ruby_version_is '1.9' do
  describe "Kernel#Complex" do
    it "returns an Integer if imaginary part is 0" do
      Complex(42,0).should == 42
      Complex(42,0).should be_kind_of(Fixnum)
      Complex(bignum_value,0).should == bignum_value
      Complex(bignum_value,0).should be_kind_of(Bignum)
    end
  end
end
