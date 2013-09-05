rails_root        = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
rails_env         = ENV['RAILS_ENV'] || 'development'

resque_config     = YAML.load_file(rails_root + '/config/resque.yml')
ENV['REDIS_URI']  = resque_config[rails_env]
Resque.redis      = resque_config[rails_env]
Resque.inline     = Rails.env.test?

require 'resque_scheduler'
require 'resque/scheduler'

Resque.schedule   = YAML.load_file(rails_root + '/config/resque-schedule.yml')
