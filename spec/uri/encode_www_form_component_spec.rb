require 'uri'

describe 'URI.encode_www_form_component' do
  it 'encodes a space' do
    URI.encode_www_form_component(' ').should == '+'
  end

  it 'encodes an @ sign' do
    URI.encode_www_form_component('@').should == '%40'
  end

  it 'encodes a curly brace' do
    URI.encode_www_form_component('}').should == '%7D'
  end
end
