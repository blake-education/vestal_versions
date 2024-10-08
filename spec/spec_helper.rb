require 'bundler'

Bundler.require

require 'simplecov' if ENV['COVERAGE'] != 'off'

require 'rspec/core'

if ActiveRecord::VERSION::MAJOR == 6
  ActiveRecord::Base.yaml_column_permitted_classes += [Time]
else
  ActiveRecord.yaml_column_permitted_classes += [Time]
end

RSpec.configure do |c|
  c.before(:suite) do
    CreateSchema.suppress_messages{ CreateSchema.migrate(:up) }
  end

  c.after(:suite) do
    FileUtils.rm_rf(File.expand_path('../test.db', __FILE__))
  end

  c.after(:each) do
    VestalVersions::Version.config.clear
    User.prepare_versioned_options({})
  end
end

Dir[File.expand_path('../support/*.rb', __FILE__)].each{|f| require f }
