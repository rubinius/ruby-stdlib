describe :tempfile_unlink, :shared => true do
  before :each do
    @tempfile = Tempfile.new("specs")
  end

  after :each do
    TempfileSpecs.cleanup @tempfile
  end

  ruby_bug "", "1.8.6" do
    it "unlinks self" do
      @tempfile.close
      path = @tempfile.path
      @tempfile.send(@method)
      File.exists?(path).should be_false
    end
  end
end
