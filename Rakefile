require "bundler/gem_tasks"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :test do |task|
  task.verbose = false
  task.rspec_opts = ['--color', '--format', 'doc']
end

task :default => :test