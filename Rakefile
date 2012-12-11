#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'BatchApi'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('readme.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
  rdoc.options = ["-C"]
end

Bundler::GemHelper.install_tasks

namespace :template do
  desc "Prepare a new gem"
  task :setup, [:class_name, :file_name] => [:rename, :setup_git, :prep_pelusa]

  task :setup_git do
    puts "Cleaning git origin..."
    puts "(origin template allows you to pull subsequent template updates.)"
    system("git remote rm origin")
    system("git remote add template git@github.com:arsduo/gem_template.git")
  end

  task :prep_pelusa do
    puts "IMPORTANT! To use pelusa linting, you must bundle install under rbx."
    # puts "Setting up rbx environment for pelusa..."
    # unless system("rvm rbx bundle install")
    #   puts "Unable to setup rbx!  Please ensure Rubinius is installed " +
    #    "and you can run bundle install using it."
    # end
  end

  desc "Rename the template gem"
  task :rename, :class_name, :file_name do |t, args|
    class_matcher = /GemTemplate/
    file_matcher = /gem_template/

    begin
      # first, we rename directories
      Dir["**/*"].each do |path|
        # now, rename any files that match the old path
        if File.directory?(path) && path =~ file_matcher
          FileUtils.mv(path, path.gsub(file_matcher, args.file_name))
        end
      end

      # now, for each file, change its contents and rename it if needed
      Dir["**/*"].each do |path|
        unless File.directory?(path)
          content = File.read(path)
          new_content = content.gsub(class_matcher, args.class_name).
                                gsub(file_matcher,  args.file_name)
          File.open(path, "w") {|f| f << new_content}

          # now, rename any files that match the old path
          if File.basename(path) =~ file_matcher
            FileUtils.mv(path, path.gsub(file_matcher, args.file_name))
          end
        end
      end

      # Finally, add and commit everything
      system "git add --all && git commit -m 'Rename gem_template to #{args.class_name}'"
      puts "Renamed to #{args.class_name}!"
    rescue
      puts "An error occurred!  Resetting all changes."
      system "git checkout . && git clean -d -f"
      raise
    end
  end
end

# RSpec
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ["--color", '--format doc', '--order rand']
end

# QA Tasks
qa_tasks = [:spec]

# Pelusa
task :lint do
  rvm = ENV["rvm_path"]

  unless system("rvm rbx do pelusa")
    fail "Pelusa static linting showed errors!"
  end
end
qa_tasks += [:lint]
qa_tasks += [:rdoc]

desc "Run all tests and documentation checks"
task :qa => qa_tasks.tap {|t| puts "Tasks: #{t}"}

task :default => :qa
