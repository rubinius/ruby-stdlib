process_is_foreground do
  with_feature :readline do
    require 'readline'

    describe "Readline.completer_word_break_characters" do
      it "returns nil" do
        Readline.completer_word_break_characters.should be_nil
      end
    end

    describe "Readline.completer_word_break_characters=" do
      it "returns the passed string" do
        Readline.completer_word_break_characters = "test"
        Readline.completer_word_break_characters.should == "test"
      end
    end
  end
end
