web:              bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker:           env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=4 bundle exec rake resque:work QUEUE=immediate,hourly,daily,two_days,weekly,monthly,open
scheduler:        bundle exec rake resque:scheduler
