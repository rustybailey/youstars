require 'resque/tasks'
require 'resque_scheduler/tasks'

task "resque:setup" => :environment do
  rails_root = ENV['RAILS_ROOT'] || File.dirname(__FILE__) + '/../..'
  Resque.schedule = YAML.load_file("#{rails_root}/config/resque-schedule.yml")
  

  Resque.after_fork do |worker|
    ActiveRecord::Base.establish_connection
    if Rails.env.production? 
      NewRelic::Agent.after_fork(
        :report_to_channel    => worker.object_id,
        :report_instance_busy => false
      )
    end
  end
end

desc "Alias for resque:work (To run workers on Heroku)"
task "jobs:work" => "resque:work"

