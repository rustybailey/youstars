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
