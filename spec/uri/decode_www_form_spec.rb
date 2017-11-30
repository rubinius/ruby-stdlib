require 'uri'

describe 'URI.decode_www_form' do
  it 'decodes a single String into an Array' do
    URI.decode_www_form('a').should == [['a', '']]
  end

  it 'decodes a single key/value parameter into an Array' do
    URI.decode_www_form('a=1').should == [['a', '1']]
  end

  it 'decodes multiple key/value parameters into an Array' do
    URI.decode_www_form('a=1&b=2').should == [['a', '1'], ['b', '2']]
  end
end
