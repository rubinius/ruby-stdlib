require File.expand_path('../fixtures/normalization', __FILE__)
require File.expand_path('../shared/eql', __FILE__)
require 'uri'

describe "URI#eql?" do
  it_behaves_like :uri_eql, :eql?

  ruby_bug "redmine:2428", "1.8.7" do
    it_behaves_like :uri_eql_against_other_types, :eql?
  end
end
