source "https://rubygems.org"

# Specify your gem's dependencies in pg_replication_monitor.gemspec
gemspec

gem "rake"

group :development, :test do
  # pry rocks
  gem "pry"

  # Testing infrastructure
  gem "guard"
  gem "guard-rspec"
  gem "faker"
  gem "timecop"

  # Code quality
  gem "rdoc"
  gem "pelusa", path: "/Users/alexanderkoppel/external/pelusa" # github: "arsduo/pelusa"

  if RUBY_PLATFORM =~ /darwin/
    # OS X integration
    gem "growl"
    gem "rb-fsevent"
  end
end
