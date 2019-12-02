require 'fcntl'

require 'socket/rubinius/socket'
require 'socket/rubinius/socket/version'
require 'socket/rubinius/socket/socket_options'

require 'socket/socket_error'
require 'socket/basic_socket'
require 'socket/constants'

require 'socket/rubinius/socket/foreign/addrinfo'
require 'socket/rubinius/socket/foreign/linger'
require 'socket/rubinius/socket/foreign/ifaddrs'
require 'socket/rubinius/socket/foreign/sockaddr'
require 'socket/rubinius/socket/foreign/sockaddr_in'
require 'socket/rubinius/socket/foreign/sockaddr_in6'

if RubySL::Socket.unix_socket_support?
  require 'socket/rubinius/socket/foreign/sockaddr_un'
end

require 'socket/rubinius/socket/foreign/iovec'
require 'socket/rubinius/socket/foreign/msghdr'
require 'socket/rubinius/socket/foreign/hostent'
require 'socket/rubinius/socket/foreign/servent'

require 'socket/rubinius/socket/ipv6'
require 'socket/rubinius/socket/ancillary_data'
require 'socket/rubinius/socket/foreign'
require 'socket/rubinius/socket/error'
require 'socket/rubinius/socket/bsd' if RubySL::Socket.bsd_support?
require 'socket/rubinius/socket/linux' if RubySL::Socket.linux_support?

require 'socket/socket'
require 'socket/option'
require 'socket/ancillary_data'
require 'socket/mri'
require 'socket/unix_socket'
require 'socket/unix_server'
require 'socket/ip_socket'
require 'socket/udp_socket'
require 'socket/tcp_socket'
require 'socket/tcp_server'
require 'socket/addrinfo'
require 'socket/ifaddr'
