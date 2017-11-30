class Object
  def each_ip_protocol
    describe 'using IPv4' do
      yield Socket::AF_INET, '127.0.0.1', 'AF_INET'
    end

    describe 'using IPv6' do
      yield Socket::AF_INET6, '::1', 'AF_INET6'
    end
  end
end
