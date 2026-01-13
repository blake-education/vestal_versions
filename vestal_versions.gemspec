require_relative './lib/vestal_versions/version_num'

Gem::Specification.new do |s|
  s.name    = 'vestal_versions'
  s.version = VestalVersions::VERSION

  s.authors     = ['Steve Richert', "James O'Kelly"]
  s.email       = ['steve.richert@gmail.com', 'dreamr.okelly@gmail.com']
  s.description = "Keep a DRY history of your ActiveRecord models' changes"
  s.summary     = s.description
  s.homepage    = 'http://github.com/laserlemon/vestal_versions'

  s.add_dependency 'activerecord', '>= 6.1', '< 8.2'
  s.add_dependency 'activesupport', '>= 6.1', '< 8.2'

  s.files         = Dir['{*.md,Gemfile,*.gemspec,Rakefile,lib/**/*,gemfiles/**/*}']
  s.require_paths = ['lib']
end
