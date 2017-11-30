require 'rexml/document'

describe "REXML::Element#node_type" do
  it "returns :element" do
    REXML::Element.new("MyElem").node_type.should == :element
  end
end
