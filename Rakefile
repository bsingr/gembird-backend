#!/usr/bin/env rake
require "bundler/gem_tasks"

# rspec
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

# default to spec (required by travis ci)
task :default => :spec
