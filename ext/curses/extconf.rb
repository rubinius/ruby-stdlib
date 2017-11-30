require 'mkmf'

def have_all(*args) # :nodoc:
  old_libs = $libs.dup
  old_defs = $defs.dup
  result = []
  begin
    args.each {|arg|
      r = arg.call(*result)
      if !r
        return nil
      end
      result << r
    }
    result
  ensure
    if result.length != args.length
      $libs = old_libs
      $defs = old_defs
    end
  end
end

dir_config('curses')
dir_config('ncurses')
dir_config('termcap')

have_library("mytinfo", "tgetent") if /bow/ =~ RUBY_PLATFORM
have_library("tinfo", "tgetent") or have_library("termcap", "tgetent")

header_library = nil
[
  ["ncurses.h", ["ncursesw", "ncurses"]],
  ["ncurses/curses.h", ["ncurses"]],
  ["curses_colr/curses.h", ["cur_colr"]],
  ["curses.h", ["curses", "pdcurses"]],
  # ["xcurses.h", ["XCurses"]], # XCurses (PDCurses for X11)
].each {|hdr, libs|
  header_library = have_all(
    lambda { have_header(hdr) && hdr },
    lambda {|h| libs.find {|lib| have_library(lib, "initscr", h) } })
  if header_library
    break;
  end
}

if header_library
  header, library = header_library
  puts "header: #{header}"
  puts "library: #{library}"

  curses = [header]
  if header == 'curses_colr/curses.h'
    curses.unshift("varargs.h")
  end

  for f in %w(beep bkgd bkgdset curs_set deleteln doupdate flash
              getbkgd getnstr init isendwin keyname keypad resizeterm
              scrl set setscrreg ungetch
              wattroff wattron wattrset wbkgd wbkgdset wdeleteln wgetnstr
              wresize wscrl wsetscrreg
              def_prog_mode reset_prog_mode timeout wtimeout nodelay
              init_color wcolor_set use_default_colors newpad)
    have_func(f) || (have_macro(f, curses) && $defs.push(format("-DHAVE_%s", f.upcase)))
  end
  flag = "-D_XOPEN_SOURCE_EXTENDED"
  if try_static_assert("sizeof(char*)>sizeof(int)",
                       %w[stdio.h stdlib.h]+curses,
                       flag)
    $defs << flag
  end
  have_var("ESCDELAY", curses)
  have_var("TABSIZE", curses)
  have_var("COLORS", curses)
  have_var("COLOR_PAIRS", curses)

  # SVR4 curses has a (undocumented) variable char *curses_version.
  # ncurses and PDcurses has a function char *curses_version().
  # Note that the original BSD curses doesn't provide version information.
  #
  # configure option:
  #   --with-curses-version=function    for SVR4
  #   --with-curses-version=variable    for ncurses and PDcurses
  #   (not given)                       automatically determined

  case with_curses_version = with_config("curses-version")
  when "function"
    $defs << '-DHAVE_FUNC_CURSES_VERSION'
  when "variable"
    $defs << '-DHAVE_VAR_CURSES_VERSION'
  when nil
    func_test_program = cpp_include(curses) + <<-"End"
      int main(int argc, char *argv[])
      {
          curses_version();
          return EXIT_SUCCESS;
      }
    End
    var_test_program = cpp_include(curses) + <<-"End"
      extern char *curses_version;
      int main(int argc, char *argv[])
      {
          int i = 0;
          for (i = 0; i < 100; i++) {
              if (curses_version[i] == 0)
                  return 0 < i ? EXIT_SUCCESS : EXIT_FAILURE;
              if (curses_version[i] & 0x80)
                  return EXIT_FAILURE;
          }
          return EXIT_FAILURE;
      }
    End
    try = method(CROSS_COMPILING ? :try_link : :try_run)
    function_p = checking_for(checking_message('function curses_version', curses)) { try[func_test_program] }
    variable_p = checking_for(checking_message('variable curses_version', curses)) { try[var_test_program] }
    if function_p and variable_p
      if [header, library].grep(/ncurses|pdcurses|xcurses/i)
        variable_p = false
      else
        warn "found curses_version but cannot determin whether it is a"
        warn "function or a variable, so assume a variable in old SVR4"
        warn "ncurses."
        function_p = false
      end
    end
    $defs << '-DHAVE_FUNC_CURSES_VERSION' if function_p
    $defs << '-DHAVE_VAR_CURSES_VERSION' if variable_p
  else
    warn "unexpeted value for --with-curses-version: #{with_curses_version}"
  end

  create_makefile("curses/curses")
end
