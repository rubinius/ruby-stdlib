require 'bigdecimal'

describe "BigDecimal#round" do
  before :each do
    @one   = BigDecimal("1")
    @two   = BigDecimal("2")
    @three = BigDecimal("3")

    @neg_one   = BigDecimal("-1")
    @neg_two   = BigDecimal("-2")
    @neg_three = BigDecimal("-3")

    @p1_50 = BigDecimal("1.50")
    @p1_51 = BigDecimal("1.51")
    @p1_49 = BigDecimal("1.49")
    @n1_50 = BigDecimal("-1.50")
    @n1_51 = BigDecimal("-1.51")
    @n1_49 = BigDecimal("-1.49")

    @p2_50 = BigDecimal("2.50")
    @p2_51 = BigDecimal("2.51")
    @p2_49 = BigDecimal("2.49")
    @n2_50 = BigDecimal("-2.50")
    @n2_51 = BigDecimal("-2.51")
    @n2_49 = BigDecimal("-2.49")
  end

  after :each do
    BigDecimal.mode(BigDecimal::ROUND_MODE, BigDecimal::ROUND_HALF_UP)
  end

  it "uses default rounding method unless given" do
    @p1_50.round(0).should == @two
    @p1_51.round(0).should == @two
    @p1_49.round(0).should == @one
    @n1_50.round(0).should == @neg_two
    @n1_51.round(0).should == @neg_two
    @n1_49.round(0).should == @neg_one

    @p2_50.round(0).should == @three
    @p2_51.round(0).should == @three
    @p2_49.round(0).should == @two
    @n2_50.round(0).should == @neg_three
    @n2_51.round(0).should == @neg_three
    @n2_49.round(0).should == @neg_two

    BigDecimal.mode(BigDecimal::ROUND_MODE, BigDecimal::ROUND_DOWN)

    @p1_50.round(0).should == @one
    @p1_51.round(0).should == @one
    @p1_49.round(0).should == @one
    @n1_50.round(0).should == @neg_one
    @n1_51.round(0).should == @neg_one
    @n1_49.round(0).should == @neg_one

    @p2_50.round(0).should == @two
    @p2_51.round(0).should == @two
    @p2_49.round(0).should == @two
    @n2_50.round(0).should == @neg_two
    @n2_51.round(0).should == @neg_two
    @n2_49.round(0).should == @neg_two
  end

  describe "with special constants" do
    it "doesn't alter NaN's value" do
      BigDecimal("NaN").round(1).nan?.should == true
    end

    it "doesn't alter Infinity's value" do
      BigDecimal("Infinity").round(1).should == BigDecimal("Infinity")
      BigDecimal("-Infinity").round(1).should == BigDecimal("-Infinity")
    end
  end

  describe "with special constants and no rounding values" do
    it "raises with NaN" do
      lambda {
        BigDecimal("NaN").round
      }.should raise_error(FloatDomainError)
    end

    it "raises with Infinity" do
      lambda {
        BigDecimal("Infinity").round
      }.should raise_error(FloatDomainError)

      lambda {
        BigDecimal("-Infinity").round
      }.should raise_error(FloatDomainError)
    end
  end

  describe "BigDecimal::ROUND_UP" do
    it "rounds values away from zero" do
      @p1_50.round(0, BigDecimal::ROUND_UP).should == @two
      @p1_51.round(0, BigDecimal::ROUND_UP).should == @two
      @p1_49.round(0, BigDecimal::ROUND_UP).should == @two
      @n1_50.round(0, BigDecimal::ROUND_UP).should == @neg_two
      @n1_51.round(0, BigDecimal::ROUND_UP).should == @neg_two
      @n1_49.round(0, BigDecimal::ROUND_UP).should == @neg_two

      @p2_50.round(0, BigDecimal::ROUND_UP).should == @three
      @p2_51.round(0, BigDecimal::ROUND_UP).should == @three
      @p2_49.round(0, BigDecimal::ROUND_UP).should == @three
      @n2_50.round(0, BigDecimal::ROUND_UP).should == @neg_three
      @n2_51.round(0, BigDecimal::ROUND_UP).should == @neg_three
      @n2_49.round(0, BigDecimal::ROUND_UP).should == @neg_three
    end
  end

  describe "BigDecimal::ROUND_DOWN" do
    it "rounds values towards zero" do
      @p1_50.round(0, BigDecimal::ROUND_DOWN).should == @one
      @p1_51.round(0, BigDecimal::ROUND_DOWN).should == @one
      @p1_49.round(0, BigDecimal::ROUND_DOWN).should == @one
      @n1_50.round(0, BigDecimal::ROUND_DOWN).should == @neg_one
      @n1_51.round(0, BigDecimal::ROUND_DOWN).should == @neg_one
      @n1_49.round(0, BigDecimal::ROUND_DOWN).should == @neg_one

      @p2_50.round(0, BigDecimal::ROUND_DOWN).should == @two
      @p2_51.round(0, BigDecimal::ROUND_DOWN).should == @two
      @p2_49.round(0, BigDecimal::ROUND_DOWN).should == @two
      @n2_50.round(0, BigDecimal::ROUND_DOWN).should == @neg_two
      @n2_51.round(0, BigDecimal::ROUND_DOWN).should == @neg_two
      @n2_49.round(0, BigDecimal::ROUND_DOWN).should == @neg_two
    end
  end

  describe "BigDecimal::ROUND_HALF_UP" do
    it "rounds values >= 5 up, otherwise down" do
      @p1_50.round(0, BigDecimal::ROUND_HALF_UP).should == @two
      @p1_51.round(0, BigDecimal::ROUND_HALF_UP).should == @two
      @p1_49.round(0, BigDecimal::ROUND_HALF_UP).should == @one
      @n1_50.round(0, BigDecimal::ROUND_HALF_UP).should == @neg_two
      @n1_51.round(0, BigDecimal::ROUND_HALF_UP).should == @neg_two
      @n1_49.round(0, BigDecimal::ROUND_HALF_UP).should == @neg_one

      @p2_50.round(0, BigDecimal::ROUND_HALF_UP).should == @three
      @p2_51.round(0, BigDecimal::ROUND_HALF_UP).should == @three
      @p2_49.round(0, BigDecimal::ROUND_HALF_UP).should == @two
      @n2_50.round(0, BigDecimal::ROUND_HALF_UP).should == @neg_three
      @n2_51.round(0, BigDecimal::ROUND_HALF_UP).should == @neg_three
      @n2_49.round(0, BigDecimal::ROUND_HALF_UP).should == @neg_two
    end
  end

  ruby_bug "redmine:3803/4567", "1.9.2" do
    describe "BigDecimal::ROUND_HALF_DOWN" do
      it "rounds values > 5 up, otherwise down" do
        @p1_50.round(0, BigDecimal::ROUND_HALF_DOWN).should == @one
        @p1_51.round(0, BigDecimal::ROUND_HALF_DOWN).should == @two
        @p1_49.round(0, BigDecimal::ROUND_HALF_DOWN).should == @one
        @n1_50.round(0, BigDecimal::ROUND_HALF_DOWN).should == @neg_one
        @n1_51.round(0, BigDecimal::ROUND_HALF_DOWN).should == @neg_two
        @n1_49.round(0, BigDecimal::ROUND_HALF_DOWN).should == @neg_one

        @p2_50.round(0, BigDecimal::ROUND_HALF_DOWN).should == @two
        @p2_51.round(0, BigDecimal::ROUND_HALF_DOWN).should == @three
        @p2_49.round(0, BigDecimal::ROUND_HALF_DOWN).should == @two
        @n2_50.round(0, BigDecimal::ROUND_HALF_DOWN).should == @neg_two
        @n2_51.round(0, BigDecimal::ROUND_HALF_DOWN).should == @neg_three
        @n2_49.round(0, BigDecimal::ROUND_HALF_DOWN).should == @neg_two
      end
    end
  end

  describe "BigDecimal::ROUND_CEILING" do
    it "rounds values towards +infinity" do
      @p1_50.round(0, BigDecimal::ROUND_CEILING).should == @two
      @p1_51.round(0, BigDecimal::ROUND_CEILING).should == @two
      @p1_49.round(0, BigDecimal::ROUND_CEILING).should == @two
      @n1_50.round(0, BigDecimal::ROUND_CEILING).should == @neg_one
      @n1_51.round(0, BigDecimal::ROUND_CEILING).should == @neg_one
      @n1_49.round(0, BigDecimal::ROUND_CEILING).should == @neg_one

      @p2_50.round(0, BigDecimal::ROUND_CEILING).should == @three
      @p2_51.round(0, BigDecimal::ROUND_CEILING).should == @three
      @p2_49.round(0, BigDecimal::ROUND_CEILING).should == @three
      @n2_50.round(0, BigDecimal::ROUND_CEILING).should == @neg_two
      @n2_51.round(0, BigDecimal::ROUND_CEILING).should == @neg_two
      @n2_49.round(0, BigDecimal::ROUND_CEILING).should == @neg_two
    end
  end

  describe "BigDecimal::ROUND_FLOOR" do
    it "rounds values towards -infinity" do
      @p1_50.round(0, BigDecimal::ROUND_FLOOR).should == @one
      @p1_51.round(0, BigDecimal::ROUND_FLOOR).should == @one
      @p1_49.round(0, BigDecimal::ROUND_FLOOR).should == @one
      @n1_50.round(0, BigDecimal::ROUND_FLOOR).should == @neg_two
      @n1_51.round(0, BigDecimal::ROUND_FLOOR).should == @neg_two
      @n1_49.round(0, BigDecimal::ROUND_FLOOR).should == @neg_two

      @p2_50.round(0, BigDecimal::ROUND_FLOOR).should == @two
      @p2_51.round(0, BigDecimal::ROUND_FLOOR).should == @two
      @p2_49.round(0, BigDecimal::ROUND_FLOOR).should == @two
      @n2_50.round(0, BigDecimal::ROUND_FLOOR).should == @neg_three
      @n2_51.round(0, BigDecimal::ROUND_FLOOR).should == @neg_three
      @n2_49.round(0, BigDecimal::ROUND_FLOOR).should == @neg_three
    end
  end

  ruby_bug "redmine:3803/4567", "1.9.2" do
    describe "BigDecimal::ROUND_HALF_EVEN" do
      it "rounds values > 5 up, < 5 down and == 5 towards even neighbor" do
        @p1_50.round(0, BigDecimal::ROUND_HALF_EVEN).should == @two
        @p1_51.round(0, BigDecimal::ROUND_HALF_EVEN).should == @two
        @p1_49.round(0, BigDecimal::ROUND_HALF_EVEN).should == @one
        @n1_50.round(0, BigDecimal::ROUND_HALF_EVEN).should == @neg_two
        @n1_51.round(0, BigDecimal::ROUND_HALF_EVEN).should == @neg_two
        @n1_49.round(0, BigDecimal::ROUND_HALF_EVEN).should == @neg_one

        @p2_50.round(0, BigDecimal::ROUND_HALF_EVEN).should == @two
        @p2_51.round(0, BigDecimal::ROUND_HALF_EVEN).should == @three
        @p2_49.round(0, BigDecimal::ROUND_HALF_EVEN).should == @two
        @n2_50.round(0, BigDecimal::ROUND_HALF_EVEN).should == @neg_two
        @n2_51.round(0, BigDecimal::ROUND_HALF_EVEN).should == @neg_three
        @n2_49.round(0, BigDecimal::ROUND_HALF_EVEN).should == @neg_two
      end
    end
  end
end
