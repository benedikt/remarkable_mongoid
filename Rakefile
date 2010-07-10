require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = "remarkable-mongoid"
    gem.summary     = %Q{RSpec Matchers for Mongoid}
    gem.description = %Q{RSpec Matchers for Mongoid}
    gem.email       = "bcardarella@gmail.com"
    gem.homepage    = "http://github.com/bcardarella/remarkable-mongoid"
    gem.authors     = ["Brian Cardarella"]
    gem.files       = Dir.glob("lib/**/*") + %w(LICENSE README.markdown)
    gem.test_files  = []
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
