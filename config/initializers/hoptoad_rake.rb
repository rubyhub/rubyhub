class Rake::Application
  def standard_exception_handling
    begin
      yield
    rescue SystemExit => ex
      # Exit silently with current status
      raise
    rescue OptionParser::InvalidOption => ex
      # Exit silently
      exit(false)
    rescue Exception => ex
      if tty_output?
        # Exit with error message
        $stderr.puts "#{name} aborted!"
        $stderr.puts ex.message
        if options.trace
          $stderr.puts ex.backtrace.join("\n")
        else
          $stderr.puts ex.backtrace.find {|str| str =~ /#{@rakefile}/ } || ""
          $stderr.puts "(See full trace by running task with --trace)"
        end
      else
        HoptoadNotifier.notify(ex)
      end
      exit(false)
    end
  end
end
