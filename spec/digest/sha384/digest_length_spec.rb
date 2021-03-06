require File.expand_path('../shared/constants', __FILE__)

describe "Digest::SHA384#digest_length" do

  it "returns the length of computed digests" do
    cur_digest = Digest::SHA384.new
    cur_digest.digest_length.should == SHA384Constants::DigestLength
  end

end

