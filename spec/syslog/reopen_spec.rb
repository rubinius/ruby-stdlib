require File.expand_path('../shared/reopen', __FILE__)
require 'syslog'

describe "Syslog.reopen" do
  it_behaves_like :syslog_reopen, :reopen
end
