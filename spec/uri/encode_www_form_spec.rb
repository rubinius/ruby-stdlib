require 'uri'

describe 'URI.encode_www_form' do
  it 'encodes a single Array into a String' do
    URI.encode_www_form([['a', '1']]).should == 'a=1'
  end

  it 'encodes multiple Arrays into a String' do
    URI.encode_www_form([['a', '1'], ['b', '2']]).should == 'a=1&b=2'
  end
end
