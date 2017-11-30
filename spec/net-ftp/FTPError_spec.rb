require 'net/ftp'

describe "Net::FTPError" do
  it "is an Exception" do
    Net::FTPError.should < Exception
  end
end
