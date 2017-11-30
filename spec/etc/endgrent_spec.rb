require File.expand_path('../shared/windows', __FILE__)
require 'etc'

describe "Etc.endgrent" do
  it_behaves_like(:etc_on_windows, :endgrent)
end
