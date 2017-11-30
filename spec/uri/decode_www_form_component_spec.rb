# encoding: utf-8

require 'uri'

describe 'URI.decode_www_form_component' do
  it 'decodes an URL encoded space' do
    URI.decode_www_form_component('%20').should == ' '
  end

  it 'decodes an URL encoded curly brace' do
    URI.decode_www_form_component('%7D').should == '}'
  end

  it 'decodes an URL encoded @ sign' do
    URI.decode_www_form_component('%40').should == '@'
  end

  it 'decodes URL encoded multi-byte characters' do
    URI.decode_www_form_component("\xE3\x81\x82%E3%81%82").should == 'ああ'
  end
end
