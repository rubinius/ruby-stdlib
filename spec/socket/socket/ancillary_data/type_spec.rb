require 'socket'

describe 'Socket::AncillaryData#type' do
  it 'returns the type as a Fixnum' do
    Socket::AncillaryData.new(:INET, :SOCKET, :RIGHTS, '').type
      .should == Socket::SCM_RIGHTS
  end
end
