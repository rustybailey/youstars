# Youstars
Youstars is a **better** frontend for YouTube pages.

## Setup
Youstars is a Rails 4 app. You must use it with Ruby 2.0 with the latest available patch level.

Clone the repo
```
git clone git@github.com:devilshaircut/youstars.git
```

Bundle Install/Create Database
```
cd path/to/youstars
bundle install
rake db:create db:migrate
```

Set up Pow
```
cd ~/.pow
ln -s ~/path/to/youstars
```

Go to http://www.youstars.dev and you should be good to go.

## OAuthing

To oAuth a Google/YouTube account, you actually have to be running on localhost.  You can't do that with pow.  It's simple, though.  Just run the standard rails server:

```
rails s
```

Which should default you to localhost:3000.  You have to be using the localhost:3000 server for this to work (Google OA2 Restriction).  Alternatively, if you're using apache or something, just configure appropriately.  But ```rails s``` is the easiest way by far.
