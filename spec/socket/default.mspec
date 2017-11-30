$:.unshift(File.expand_path('..', __FILE__))

require 'socket'
require 'custom/helpers/each_ip_protocol'
require 'custom/helpers/loop_with_timeout'
require 'custom/helpers/wait_until_success'

# This ensures we can actually read backtraces Travis CI might spit out.
if ENV['TRAVIS'] and RUBY_ENGINE == 'rbx'
  Rubinius::TERMINAL_WIDTH = 120
end

Thread.abort_on_exception = true

class MSpecScript
  if RUBY_ENGINE == 'rbx'
    MSpec.enable_feature :pure_ruby_addrinfo
  end

  if Socket.const_defined?(:SOCK_PACKET)
    MSpec.enable_feature :sock_packet
  end

  if Socket.const_defined?(:AF_UNIX)
    MSpec.enable_feature :unix_socket
  end

  if Socket.const_defined?(:UDP_CORK)
    MSpec.enable_feature :udp_cork
  end

  if Socket.const_defined?(:TCP_CORK)
    MSpec.enable_feature :tcp_cork
  end

  if Socket.const_defined?(:IPV6_PKTINFO)
    MSpec.enable_feature :ipv6_pktinfo
  end

  if Socket.const_defined?(:IP_MTU)
    MSpec.enable_feature :ip_mtu
  end

  if Socket.const_defined?(:IPV6_NEXTHOP)
    MSpec.enable_feature :ipv6_nexthop
  end

  if Socket.const_defined?(:TCP_INFO)
    MSpec.enable_feature :tcp_info
  end

  set :backtrace_filter, %r{(bin/mspec|lib/mspec|kernel)}
end

# vim: set ft=ruby:
