process_is_foreground do
  with_feature :readline do
    require 'readline'

    describe "Readline.emacs_editing_mode" do
      it "returns nil" do
        Readline.emacs_editing_mode.should be_nil
      end
    end
  end
end
