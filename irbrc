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
IRB.conf[:SAVE_HISTORY] = 10000
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

# https://gist.github.com/wtaysom/1236979
module Where
  class << self
    attr_accessor :editor

    def is_proc(proc)
      source_location(proc)
    end

    def is_method(klass, method_name)
      source_location(klass.method(method_name))
    end

    def is_instance_method(klass, method_name)
      source_location(klass.instance_method(method_name))
    end

    def are_methods(klass, method_name)
      are_via_extractor(:method, klass, method_name)
    end

    def are_instance_methods(klass, method_name)
      are_via_extractor(:method, klass, method_name)
    end

    def is_class(klass)
      methods = defined_methods(klass)
      file_groups = methods.group_by{|sl| sl[0]}
      file_counts = file_groups.map do |file, sls|
        lines = sls.map{|sl| sl[1]}
        count = lines.size
        line = lines.min
        {file: file, count: count, line: line}
      end
      file_counts.sort_by!{|fc| fc[:count]}
      source_locations = file_counts.map{|fc| [fc[:file], fc[:line]]}
      source_locations
    end

    # Raises ArgumentError if klass does not have any Ruby methods defined in it.
    def is_class_primarily(klass)
      source_locations = is_class(klass)
      if source_locations.empty?
        methods = defined_methods(klass)
        raise ArgumentError, (methods.empty? ?
          "#{klass} has no methods" :
          "#{klass} only has built-in methods (#{methods.size} in total)"
        )
      end
      source_locations[0]
    end

    def edit(location)
      unless location.kind_of?(Array)
        raise TypeError,
          "only accepts a [file, line_number] array"
      end
      editor[*location]
      location
    end

  private

    def source_location(method)
      method.source_location || (
        method.to_s =~ /: (.*)>/
        $1
      )
    end

    def are_via_extractor(extractor, klass, method_name)
      methods = klass.ancestors.map do |ancestor|
        method = ancestor.send(extractor, method_name)
        if method.owner == ancestor
          source_location(method)
        else
          nil
        end
      end
      methods.compact!
      methods
    end

    def defined_methods(klass)
      methods = klass.methods(false).map{|m| klass.method(m)} +
        klass.instance_methods(false).map{|m| klass.instance_method(m)}
      methods.map!(&:source_location)
      methods.compact!
      methods
    end
  end

  Editor = lambda do |file, line|
    puts "coda #{file}"
    system "open -b com.panic.Coda2 #{file}"
  end

  @editor = Editor
end

def where_is(klass, method = nil)
  Where.edit(if method
    begin
      Where.is_instance_method(klass, method)
    rescue NameError
      Where.is_method(klass, method)
    end
  else
    Where.is_class_primarily(klass)
  end)
end

if __FILE__ == $0
  class World
    def self.carmen
    end
  end

  where_is(World, :carmen)
end


# load railsrc
load File.dirname(__FILE__) + '/.railsrc' if ENV['RAILS_ENV'] || defined? Rails

puts "#{RUBY_DESCRIPTION.split(' ')[0..1].join(' ').capitalize}"
