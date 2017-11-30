require 'net/ftp'
require File.expand_path('../shared/pwd', __FILE__)

describe "Net::FTP#getdir" do
  it_behaves_like :net_ftp_pwd, :getdir
end
