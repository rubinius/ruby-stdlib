describe "Tempfile#create" do
  before do
    @path = nil
  end

  describe "with block" do
    it "should exist inside the block" do
      Tempfile.create("tempfile-create") do |f|
        @path = f.path
        File.exist?(@path).should be_true
      end
    end

    it "should be deleted after the block finishes" do
      Tempfile.create("tempfile-create") do |f|
        @path = f.path
      end
      File.exist?(@path).should_not be_true
    end
  end

  describe "without block" do
    before do
      @tempfile = Tempfile.create("tempfile-create")
    end

    it "should not be deleted before closing" do
      @path = @tempfile.path
      File.exist?(@path).should be_true
    end

    it "should not be deleted after closing" do
      @path = @tempfile.path
      @tempfile.close
      File.exist?(@path).should be_true
    end
  end
end
