require File.expand_path('../shared/windows', __FILE__)
require 'etc'

describe "Etc.getgrent" do
  it_behaves_like(:etc_on_windows, :getgrent)
end
