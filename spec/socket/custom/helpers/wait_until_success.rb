require 'time'
require 'timeout'

class Object
  def wait_until_success(timeout = 5)
    loop_with_timeout(timeout) do
      begin
        return yield
      rescue
      end
    end
  end
end
