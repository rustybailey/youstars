# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

require 'resque/server'


# Set the AUTH env variable to your basic auth password to protect Resque.
AUTH_USERNAME = 'admin'
AUTH_PASSWORD = 'th1nkb1g'
if AUTH_PASSWORD and AUTH_USERNAME
  Resque::Server.use Rack::Auth::Basic do |username, password|
    username == AUTH_USERNAME and password == AUTH_PASSWORD 
  end
end

run Rack::URLMap.new \
  "/"       => Rails.application,
  "/resque" => Resque::Server.new
