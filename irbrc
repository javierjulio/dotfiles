#!/usr/bin/ruby
# 
# Resources
# https://gist.github.com/406963
# https://github.com/atmos/smeagol/blob/master/cookbooks/ruby/templates/default/dot.irbrc.erb
# https://github.com/holman/dotfiles/blob/master/ruby/irbrc.symlink

require 'irb/completion' # Tab Completion
require 'irb/ext/save-history'
require 'pp' # Pretty Print method
require 'rubygems' # Make gems available

# Awesome Print gem (gem install awesome_print)
begin
  require 'ap'
rescue LoadError
  puts "ap is not installed. To enable, run: gem install awesome_print"
end

# Print information about any HTTP requests being made
begin
  require 'net-http-spy'
rescue LoadError
  puts "net-http-spy is not installed. To enable, run: gem install net-http-spy"
end

# Automatic Indentation
IRB.conf[:AUTO_INDENT] = true

# Remove the annoying irb(main):001:0 and replace with >>
IRB.conf[:PROMPT_MODE]  = :SIMPLE

# Save History between irb sessions
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"

class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
  
  # print documentation
  #
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    puts `ri '#{method}'`
  end
end

# Print database schema for the provided Rails model
def show_schema(obj)
  y(obj.send("column_names"))
end

def r
  reload!
end

# Clear the screen
def clear
  system 'clear'
  if ENV['RAILS_ENV']
    return "Rails environment: " + ENV['RAILS_ENV']
  else
    return "No rails environment - happy hacking!";
  end
end

# http://ozmm.org/posts/time_in_irb.html
def time(times = 1)
  require 'benchmark'
  ret = nil
  Benchmark.bm { |x| x.report { times.times { ret = yield } } }
  ret
end

# Log to STDOUT if in Rails
if defined?(Rails) and !Rails.env.nil?
  if Rails.logger
    Rails.logger = Logger.new(STDOUT)
    ActiveRecord::Base.logger = Rails.logger
  end
end
