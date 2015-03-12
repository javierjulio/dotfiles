#!/usr/bin/ruby
#
# Resources
# https://gist.github.com/406963
# https://github.com/atmos/smeagol/blob/master/cookbooks/ruby/templates/default/dot.irbrc.erb
# https://github.com/holman/dotfiles/blob/master/ruby/irbrc.symlink

%w[
  rubygems
  irb/completion
  irb/ext/save-history
  pp
  awesome_print
].each do |path|
  begin
    require path
  rescue LoadError
    puts "#{path} is not installed. Run: gem install #{path}"
  end
end

# Automatic Indentation
IRB.conf[:AUTO_INDENT] = true

# Remove the annoying irb(main):001:0 and replace with >>
IRB.conf[:PROMPT_MODE] = :SIMPLE

# Save History between irb sessions
IRB.conf[:SAVE_HISTORY] = 5000
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

def r
  reload!
end

def q
  exit
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

# load railsrc
load File.dirname(__FILE__) + '/.railsrc' if ENV['RAILS_ENV'] || defined? Rails

puts "#{RUBY_DESCRIPTION.split(' ')[0..1].join(' ').capitalize}"
