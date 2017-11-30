require 'net/http'
require File.expand_path('../fixtures/classes', __FILE__)
require File.expand_path('../shared/each_name', __FILE__)

describe "Net::HTTPHeader#each_name" do
  it_behaves_like :net_httpheader_each_name, :each_name
end
