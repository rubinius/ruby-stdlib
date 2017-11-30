# This file is generated FFI::FileProcessor from etc.rb.ffi.

class Struct::Passwd < Rubinius::FFI::Struct
  layout :pw_name, :string, 0,
         :pw_passwd, :string, 8,
         :pw_uid, :uid_t, 16,
         :pw_gid, :gid_t, 20,
         :pw_gecos, :string, 40,
         :pw_dir, :string, 48,
         :pw_shell, :string, 56









  def name; self[:pw_name]; end
  def passwd; self[:pw_passwd]; end
  def uid; self[:pw_uid]; end
  def gid; self[:pw_gid]; end
  def gecos; self[:pw_gecos]; end
  def dir; self[:pw_dir]; end
  def shell; self[:pw_shell]; end
end

class Struct::Group < Rubinius::FFI::Struct
  layout :gr_name, :string, 0,
         :gr_passwd, :string, 8,
         :gr_gid, :gid_t, 16,
         :gr_mem, :pointer, 24









  FFI = Rubinius::FFI

  def name; self[:gr_name]; end
  def gid; self[:gr_gid]; end
  def passwd; self[:gr_passwd]; end
  def mem
    ptr = self[:gr_mem].read_pointer

    ary = []
    i = 1

    while not ptr.null? do
      ary << ptr.read_string
      ptr = (self[:gr_mem] + i * FFI::Pointer.size).read_pointer
      i += 1
    end

    ary
  end
end

module Etc
  FFI = Rubinius::FFI

  const_set(:Passwd, Struct::Passwd)
  const_set(:Group, Struct::Group)

  def self.getlogin
    getpwuid.name
  end

  def self.getpwnam(name)
    login = StringValue(name)

    passwd_ptr = FFI::Platform::POSIX.getpwnam(name)
    if passwd_ptr.nil?
      raise ArgumentError, "cannot find user - #{name}"
    end

    Struct::Passwd.new(passwd_ptr)
  end

  def self.getpwuid(uid = Process.uid)
    uid = Rubinius::Type.coerce_to(uid, Integer, :to_int)

    passwd_ptr = FFI::Platform::POSIX.getpwuid(uid)
    if passwd_ptr.nil?
      raise ArgumentError, "cannot find user - #{uid}"
    end

    Struct::Passwd.new(passwd_ptr)
  end

  def self.setpwent
    FFI::Platform::POSIX.setpwent
  end

  def self.getpwent
    passwd_ptr = FFI::Platform::POSIX.getpwent
    return nil if passwd_ptr.nil?

    Struct::Passwd.new(passwd_ptr)
  end

  def self.endpwent
    FFI::Platform::POSIX.endpwent
  end

  def self.passwd
    Rubinius.synchronize(self) do
      begin
        setpwent

        loop do
          pw = getpwent
          return if pw.nil?

          yield pw
        end
      ensure
        endpwent
      end
    end
  end

  def self.getgrnam(name)
    name = StringValue(name)

    group_ptr = FFI::Platform::POSIX.getgrnam(name)
    if group_ptr.nil?
      raise ArgumentError, "cannot find group - #{name}"
    end

    Struct::Group.new(group_ptr)
  end

  def self.getgrgid(gid = Process.gid)
    gid = Rubinius::Type.coerce_to(gid, Integer, :to_int)

    group_ptr = FFI::Platform::POSIX.getgrgid(gid)
    if group_ptr.nil?
      raise ArgumentError, "cannot find group - #{gid}"
    end

    Struct::Group.new(group_ptr)
  end

  def self.setgrent
    FFI::Platform::POSIX.setgrent
  end

  def self.getgrent
    group_ptr = FFI::Platform::POSIX.getgrent
    return nil if group_ptr.nil?

    Struct::Group.new(group_ptr)
  end

  def self.endgrent
    FFI::Platform::POSIX.endgrent
  end

  def self.group
    Rubinius.synchronize(self) do
      begin
        raise "parallel group iteration" if @parallel_iteration
        @parallel_iteration = true
        setgrent

        loop do
          gr = getgrent
          return if gr.nil?

          yield gr
        end
      ensure
        endgrent
        @parallel_iteration = false
      end
    end
  end
end
