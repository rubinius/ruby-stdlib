require 'rubinius/profiler'

module Profiler__
  def start_profile
    warn_not_implemented
  end

  def stop_profile
    warn_not_implemented
  end

  def options(opts)
    warn_not_implemented
  end

  def print_profile(f)
    warn_not_implemented
  end

  def warn_not_implemented
    warn "Profiler__ is not implemented"
  end

  module_function :start_profile, :stop_profile, :print_profile, :warn_not_implemented
end
