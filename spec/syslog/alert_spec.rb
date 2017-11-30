require File.expand_path('../shared/log', __FILE__)
require 'syslog'

describe "Syslog.alert" do
  it_behaves_like :syslog_log, :alert
end
