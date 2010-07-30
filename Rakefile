require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = "remarkable_mongoid"
    gem.summary     = %Q{RSpec Matchers for Mongoid}
    gem.description = %Q{RSpec Matchers for Mongoid}
    gem.email       = "bcardarella@gmail.com"
    gem.homepage    = "http://github.com/bcardarella/remarkable_mongoid"
    gem.authors     = ["Brian Cardarella"]
    gem.files       = Dir.glob("lib/**/*") + %w(LICENSE README.markdown)
    gem.test_files  = []
    gem.add_dependency 'remarkable_activemodel', '>=4.0.0.alpha2'

    gem.add_development_dependency 'ruby-debug'
    gem.add_development_dependency 'bson_ext'
    gem.add_development_dependency 'activesupport', '3.0.0.rc'
    gem.add_development_dependency 'mongoid', '2.0.0.beta.15'
    gem.add_development_dependency 'rspec', '2.0.0.beta.19'
    gem.add_development_dependency 'bourne', '1.0'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
